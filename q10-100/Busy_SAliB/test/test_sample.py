import subprocess, unittest, os

SRC_PATH = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SOL_PATH = os.path.join(SRC_PATH, "checker.sh")

class TestBusySAliB(unittest.TestCase):
    def _open(self, file_path):
        f = open(file_path)
        data = f.readlines()
        f.close()
        return data

    def _write_to_file(self, data, file_path):
        f = open(file_path, "w")
        f.write(data)
        f.close()

    def _give_access(self, file_path):
        command = 'chmod u+x ./' + file_path
        process = subprocess.Popen(command.split(), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output, error = process.communicate()

    def setUp(self):
        self.all = self._open(SOL_PATH)
        self.commands = []
        for line in self.all:
            line = line.strip()
            if line[-2:] == "\n":
                line = line[:-2]
            self.commands.append(line)

    def test_sample_exit_cmd(self):
        # Printing which test it is
        self._give_access("test/checker.sh")
        # User Stage
        run_command_user = subprocess.Popen(["bash", "./checker.sh"], stdin = subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output_user, error_user = run_command_user.communicate(input=b'add 1 6\nexit\n')
        # Assertions
        ans = "Bye Bye!"
        self.assertTrue(ans in output_user.decode("UTF-8"))

    def test_sample_free_cmd(self):
        # Printing which test it is
        self._give_access("test/checker.sh")
        # User Stage
        run_command_user = subprocess.Popen(["bash", "./checker.sh"], stdin = subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output_user, error_user = run_command_user.communicate(input=b'free 1 6\nexit\n')
        # Assertions
        ans = """You're now free from 1 to 6!
Bye Bye!"""
        self.assertTrue(ans in output_user.decode("UTF-8"))

    def test_sample_add_cmd(self):
        # Printing which test it is
        self._give_access("test/checker.sh")
        # User Stage
        run_command_user = subprocess.Popen(["bash", "./checker.sh"], stdin = subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output_user, error_user = run_command_user.communicate(input=b'add 1 6\nexit\n')
        # Assertions
        ans = """A meeting from 1 to 6 added to your day!
Bye Bye!"""
        self.assertTrue(ans in output_user.decode("UTF-8"))

    def test_sample_extra_cmd(self):
        # Printing which test it is
        self._give_access("test/checker.sh")
        # User Stage
        run_command_user = subprocess.Popen(["bash", "./checker.sh"], stdin = subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output_user, error_user = run_command_user.communicate(input=b'SAliB\nexit\n')
        # Assertions
        ans = """Command not found.
Bye Bye!"""
        self.assertTrue(ans in output_user.decode("UTF-8"))

