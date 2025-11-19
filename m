Return-Path: <linux-integrity+bounces-7641-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D0FC7128D
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 22:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36FFC4E21EC
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 21:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C01307481;
	Wed, 19 Nov 2025 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ETaF6SO+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D9E30146D;
	Wed, 19 Nov 2025 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588085; cv=none; b=SUsXYk+8IGWkfd1Pm8Isz5ZRoWm3RNGYPD5PXRY20hruOVvZFAJZWgK30jjzq+y245SWkhFib16vNeRSfF7n6D3AMVDU8WgY8VUpFqXBaPEnAsIQZKId+tNfDxkDq5sJ8fzVpBF4/8LujQDGSC7rqOPm0RZsqgRS1Ft+KEawGYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588085; c=relaxed/simple;
	bh=sQyQNTQsTfidsiNOblSUTIyiamIalHjiW2UiG8qJHv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFNVZBvsDP2NzX1JeBGE/dcLBrt0G+cgsn1VBOJ3QU6QE0HAtx7V5pT4h7STsmtMA2Glq6icyTdxVfIzOPBCU1SG5WcRfpfjvKHfaB5uAbsjsc2eLrv/K+qdPtXKKoNKkiNalMK48Zzl7GsjYr/Z/B2lu/RgyryGZqSsLizyZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ETaF6SO+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from denali.. (unknown [71.238.18.239])
	by linux.microsoft.com (Postfix) with ESMTPSA id 79C7B201AE65;
	Wed, 19 Nov 2025 13:34:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79C7B201AE65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763588082;
	bh=IfpkC4XR1qncjclCfLa3GKXcdOSGHQw6p7EbWbYy6cs=;
	h=From:To:Cc:Subject:Date:From;
	b=ETaF6SO+v7dOTWG/xJt8uxpzTA8EOmjkDv4yU8AExuL6cWzbIwp3PAvWwycRyt9u5
	 LCcozsKCxxrCw/+WAn5gKroYdmkQhdBPSj+fjWpynWsBwaAHJnpXjeHvBQ41HTEzpB
	 moYAPQRA5E55x8qqQnHq8oIFCHacJxygIP0wbB8A=
From: Anirudh Venkataramanan <anirudhve@linux.microsoft.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	Anirudh Venkataramanan <anirudhve@linux.microsoft.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Gregory Lumen <gregorylumen@linux.microsoft.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Sush Shringarputale <sushring@linux.microsoft.com>
Subject: [RFC v1 0/1] Implement IMA Event Log Trimming
Date: Wed, 19 Nov 2025 13:33:17 -0800
Message-ID: <20251119213359.39397-1-anirudhve@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

==========================================================================
| A. Introduction                                                        |
==========================================================================

IMA events are kept in kernel memory and preserved across kexec soft
reboots. This can lead to increased kernel memory usage over time,
especially with aggressive IMA policies that measure everything. To reduce
memory pressure, it becomes necessary to discard IMA events but given that
IMA events are extended into PCRs in the TPM, just discarding events will
break the PCR extension chain, making future verification of the IMA event
log impossible.

This patch series proposes a method to discard IMA events while keeping the
log verifiable. While reducing memory pressure is the primary objective,
the second order benefit of trimming the IMA log is that IMA log verifiers
(local userspace daemon or a remote cloud service) can process smaller IMA
logs on a rolling basis, thus avoiding re-verification of previously
verified events.

The method has other advantages too:

 1. It provides a userspace interface that can be used to precisely control
    trim point, allowing for trim points to be optionally aligned with
    userspace IMA event log validation.

 2. It ensures that all necessary information required for continued IMA
    log validation is made available via the userspace interface at all
    times.

 3. It provides a simple mechanism for userspace applications to determine
    if the event log has been unexpectedly trimmed.

 4. The duration for which the IMA Measurement list mutex must be held (for
    trimming) is minimal.

==========================================================================
| B. Solution                                                            |
==========================================================================

--------------------------------------------------------------------------
| B.1 Overview                                                           |
--------------------------------------------------------------------------

The kernel trims the IMA event log based on PCR values supplied by userspace.
The core principles leveraged are as follows:

 - Given an IMA event log, PCR values for each IMA event can be obtained by
   recalulating the PCR extension for each event. Thus processing N events
   from the start will yield PCR values as of event N. This is referred to
   as "IMA event log replay".

 - To get the PCR value for event N + 1, only the PCR value as of event N
   is needed. If this can be known, events till and including N can be
   safely purged.

Putting it all together, we get the following userspace + kernel flow:

 1. A userspace application replays the IMA event log to generate PCR
    values and then triggers a trim by providing these values to the kernel
    (by writing to a pseudo file). 

    Optionally, the userspace application may verify these PCR values
    against the corresponding TPM quote, and trigger trimming only if
    the calculated PCR values match up to the expectations in the quote's
    PCR digest.

 2. The kernel uses the userspace supplied PCR values to trim the IMA
    measurements list at a specific point, and so these are referred to as
    "trim-to PCR values" in this context.

    Note that the kernel doesn't really understand what these userspace
    provided PCR values mean or what IMA event they correspond to, and so
    it does its own IMA event replay till either the replayed PCR values
    match with the userspace provided ones, or it runs out of events.

    If a match is found, the kernel can proceed with trimming the IMA
    measurements list. This is done in two steps, to keep locking context
    minimal.

    step 1: Find and return the list entry (as a count from head) of exact
            match. This does not lock the measurements list mutex, ensuring
            new events can be appended to the log.

    step 2: Lock the measurements list mutex and trim the measurements list
            at the previously identified list entry.

   If the trim is successful, the trim-to PCR values are saved as "starting
   PCR values". The next time userspace wants to replay the IMA event log,
   it will use the starting PCR values as the base for the IMA event log
   replay.

--------------------------------------------------------------------------
| B.2 Kernel Interfaces                                                  |
--------------------------------------------------------------------------

A new configfs pseudo file /sys/kernel/config/ima/pcrs that supports the
following operations is exposed.

  read: returns starting PCR values stored in the kernel (within IMA
        specifically).

 write: writes trim-to PCR values to trigger trimming. If trimming is
        successful, trim-to PCR values are stored as starting PCR values.
        requires root privileges.

--------------------------------------------------------------------------
| B.3 Walk-through with a real example                                   |
--------------------------------------------------------------------------

This is a real example from a test run.

Suppose this IMA policy is deployed:

  measure func=FILE_CHECK mask=MAY_READ pcr=10
  measure func=FILE_CHECK mask=MAY_WRITE pcr=11

When the policy is deployed, a zero digest starting PCR value will be set
for each PCR used. If the TPM supports multiple hashbanks, there will be
one starting PCR value per PCR, per TPM hashbank. This can be seen in the
following hexdump:

$ sudo hexdump -vC /sys/kernel/config/ima/pcrs
00000000  70 63 72 31 30 3a 73 68  61 31 3a 00 00 00 00 00  |pcr10:sha1:.....|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 70  |...............p|
00000020  63 72 31 31 3a 73 68 61  31 3a 00 00 00 00 00 00  |cr11:sha1:......|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 70 63  |..............pc|
00000040  72 31 30 3a 73 68 61 32  35 36 3a 00 00 00 00 00  |r10:sha256:.....|
00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000060  00 00 00 00 00 00 00 00  00 00 00 70 63 72 31 31  |...........pcr11|
00000070  3a 73 68 61 32 35 36 3a  00 00 00 00 00 00 00 00  |:sha256:........|
00000080  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000090  00 00 00 00 00 00 00 00  70 63 72 31 30 3a 73 68  |........pcr10:sh|
000000a0  61 33 38 34 3a 00 00 00  00 00 00 00 00 00 00 00  |a384:...........|
000000b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
000000c0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
000000d0  00 00 00 00 00 70 63 72  31 31 3a 73 68 61 33 38  |.....pcr11:sha38|
000000e0  34 3a 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |4:..............|
000000f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000100  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000110  00 00                                             |..|
00000112

Let's say that a userspace utility replays the IMA event log, and triggers
trimming by writing the following PCR values (i.e. trim-to PCR values) to the
pseudo file:

pcr10:sha256:8268782906555cf3aefc179f815c878527dd4e67eaa836572ebabab31977922c
pcr11:sha256:4c7f31927183eacb53d51d95b0162916fd3fca51a8d1efc6dde3805eb891fe41

The trim is successful, 

1. Some number of entries from the measurements log will disappear. This
   can be verified by reading out the ASCII or binary IMA measurements
   file.

2. The trim-to PCR values are saved as starting PCR values. This can be
   verified by reading out the pseudo file again as shown below. Note that
   even through only sha256 PCR values were written, the kernel populated
   sha1 and sha384 starting values as well.

$ sudo hexdump -vC /sys/kernel/config/ima/pcrs

00000000  70 63 72 31 30 3a 73 68  61 31 3a c4 7f 9d 00 68  |pcr10:sha1:....h|
00000010  e4 86 71 bf bc ae f0 10  12 ff 68 e2 9e 74 e4 70  |..q.......h..t.p|
00000020  63 72 31 31 3a 73 68 61  31 3a 90 d7 17 ac 60 4d  |cr11:sha1:....`M|
00000030  c8 25 ce 77 7d 9d 94 cf  44 7b b2 2e 2e e2 70 63  |.%.w}...D{....pc|
00000040  72 31 30 3a 73 68 61 32  35 36 3a 82 68 78 29 06  |r10:sha256:.hx).|
00000050  55 5c f3 ae fc 17 9f 81  5c 87 85 27 dd 4e 67 ea  |U\......\..'.Ng.|
00000060  a8 36 57 2e ba ba b3 19  77 92 2c 70 63 72 31 31  |.6W.....w.,pcr11|
00000070  3a 73 68 61 32 35 36 3a  4c 7f 31 92 71 83 ea cb  |:sha256:L.1.q...|
00000080  53 d5 1d 95 b0 16 29 16  fd 3f ca 51 a8 d1 ef c6  |S.....)..?.Q....|
00000090  dd e3 80 5e b8 91 fe 41  70 63 72 31 30 3a 73 68  |...^...Apcr10:sh|
000000a0  61 33 38 34 3a 8e d6 12  18 b1 d6 cd 95 16 98 33  |a384:..........3|
000000b0  2b 7d a2 d6 d9 05 c7 e8  5b 15 b0 91 c5 fc 23 d1  |+}......[.....#.|
000000c0  f9 a8 8d 60 50 5c e9 64  5f d7 b3 b2 f1 9c 90 0a  |...`P\.d_.......|
000000d0  45 53 5d b2 57 70 63 72  31 31 3a 73 68 61 33 38  |ES].Wpcr11:sha38|
000000e0  34 3a 25 fc 21 28 31 5a  f7 c6 fb 0f 40 c9 06 e6  |4:%.!(1Z....@...|
000000f0  c5 da ed 20 61 a1 03 54  4f 67 18 88 82 0f 48 d1  |... a..TOg....H.|
00000100  2f e0 3d 36 46 5e 94 a4  88 51 f8 91 39 7e e5 97  |/.=6F^...Q..9~..|
00000110  2c c5                                             |,.|
00000112

--------------------------------------------------------------------------
| C. Footnotes                                                           |
--------------------------------------------------------------------------

1. The 'pcrs' pseudo file is currently part of configfs. This was due to
   some early internal feedback in a different context. This can as well be
   in securityfs with the rest of the IMA pseudo files.

2. PCR values are never read out of the TPM at any point. All PCR values
   used are derived from IMA event log replay.

3. Code is "RFC quality". Refinements can be made if the method is accepted.

4. For functional validation, base kernel version was 6.17 stable, with the
   most recent tested version being 6.17.8.

5. Code has been validated to some degree using a python-based internal test
   tool. This can be published if there is community interest. 

Steven Chen (1):
  ima: Implement IMA event log trimming

 drivers/Kconfig                       |   2 +
 drivers/Makefile                      |   1 +
 drivers/ima/Kconfig                   |  13 +
 drivers/ima/Makefile                  |   2 +
 drivers/ima/ima_config_pcrs.c         | 291 ++++++++++++++++++
 include/linux/ima.h                   |  27 ++
 security/integrity/ima/Makefile       |   4 +
 security/integrity/ima/ima.h          |   8 +
 security/integrity/ima/ima_init.c     |  44 +++
 security/integrity/ima/ima_log_trim.c | 421 ++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c   |   7 +-
 security/integrity/ima/ima_queue.c    |   5 +-
 12 files changed, 821 insertions(+), 4 deletions(-)
 create mode 100644 drivers/ima/Kconfig
 create mode 100644 drivers/ima/Makefile
 create mode 100644 drivers/ima/ima_config_pcrs.c
 create mode 100644 security/integrity/ima/ima_log_trim.c

-- 
2.43.0


