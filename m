Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE79011904B
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 20:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLJTE6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 14:04:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:50106 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfLJTE6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 14:04:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 11:04:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,300,1571727600"; 
   d="scan'208";a="203294114"
Received: from tstruk-mobl1.jf.intel.com (HELO [127.0.1.1]) ([10.7.196.67])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2019 11:04:58 -0800
Subject: [PATCH] tpm: selftest: add test covering async mode
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     tadeusz.struk@intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, jgg@ziepe.ca, mingo@redhat.com,
        jeffrin@rajagiritech.edu.in, linux-integrity@vger.kernel.org,
        will@kernel.org, peterhuewe@gmx.de
Date:   Tue, 10 Dec 2019 11:04:59 -0800
Message-ID: <157600469924.5042.14784541627191833405.stgit@tstruk-mobl1>
In-Reply-To: <34e5340f-de75-f20e-7898-6142eac45c13@intel.com>
References: <34e5340f-de75-f20e-7898-6142eac45c13@intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a test that sends a tpm cmd in an asyn mode.
Currently there is a gap in test coverage with regards
to this functionality.

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 tools/testing/selftests/tpm2/test_smoke.sh |    1 +
 tools/testing/selftests/tpm2/tpm2.py       |   19 +++++++++++++++++--
 tools/testing/selftests/tpm2/tpm2_tests.py |   13 +++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 80521d46220c..cb54ab637ea6 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -2,3 +2,4 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
 python -m unittest -v tpm2_tests.SmokeTest
+python -m unittest -v tpm2_tests.AsyncTest
diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
index 828c18584624..d0fcb66a88a6 100644
--- a/tools/testing/selftests/tpm2/tpm2.py
+++ b/tools/testing/selftests/tpm2/tpm2.py
@@ -6,8 +6,8 @@ import socket
 import struct
 import sys
 import unittest
-from fcntl import ioctl
-
+import fcntl
+import select
 
 TPM2_ST_NO_SESSIONS = 0x8001
 TPM2_ST_SESSIONS = 0x8002
@@ -352,6 +352,7 @@ def hex_dump(d):
 class Client:
     FLAG_DEBUG = 0x01
     FLAG_SPACE = 0x02
+    FLAG_NONBLOCK = 0x04
     TPM_IOC_NEW_SPACE = 0xa200
 
     def __init__(self, flags = 0):
@@ -362,13 +363,27 @@ class Client:
         else:
             self.tpm = open('/dev/tpmrm0', 'r+b', buffering=0)
 
+        if (self.flags & Client.FLAG_NONBLOCK):
+            flags = fcntl.fcntl(self.tpm, fcntl.F_GETFL)
+            flags |= os.O_NONBLOCK
+            fcntl.fcntl(self.tpm, fcntl.F_SETFL, flags)
+            self.tpm_poll = select.poll()
+
     def close(self):
         self.tpm.close()
 
     def send_cmd(self, cmd):
         self.tpm.write(cmd)
+
+        if (self.flags & Client.FLAG_NONBLOCK):
+            self.tpm_poll.register(self.tpm, select.POLLIN)
+            self.tpm_poll.poll(10000)
+
         rsp = self.tpm.read()
 
+        if (self.flags & Client.FLAG_NONBLOCK):
+            self.tpm_poll.unregister(self.tpm)
+
         if (self.flags & Client.FLAG_DEBUG) != 0:
             sys.stderr.write('cmd' + os.linesep)
             sys.stderr.write(hex_dump(cmd) + os.linesep)
diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index d4973be53493..728be7c69b76 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -288,3 +288,16 @@ class SpaceTest(unittest.TestCase):
 
         self.assertEqual(rc, tpm2.TPM2_RC_COMMAND_CODE |
                          tpm2.TSS2_RESMGR_TPM_RC_LAYER)
+
+class AsyncTest(unittest.TestCase):
+    def setUp(self):
+        logging.basicConfig(filename='AsyncTest.log', level=logging.DEBUG)
+
+    def test_async(self):
+        log = logging.getLogger(__name__)
+        log.debug(sys._getframe().f_code.co_name)
+
+        async_client = tpm2.Client(tpm2.Client.FLAG_NONBLOCK)
+        log.debug("Calling get_cap in a NON_BLOCKING mode")
+        async_client.get_cap(tpm2.TPM2_CAP_HANDLES, tpm2.HR_LOADED_SESSION)
+        async_client.close()

