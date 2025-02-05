Return-Path: <linux-integrity+bounces-4734-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8CFA29C38
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 22:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF871884EC5
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 21:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A9721518D;
	Wed,  5 Feb 2025 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIW9tM9B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l7yG4bGo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIW9tM9B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l7yG4bGo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A59215176
	for <linux-integrity@vger.kernel.org>; Wed,  5 Feb 2025 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792641; cv=none; b=kwu0VTaLW3vEDpIqTzisLFwKJ1TDGg5r0tsz0XF90bqvzbfrggEDlOdcV3CLdp6dNQYZTLPSxjGIQBwqC1HkFXp3TbuqH5wt1wb/r4VAd1KKK04OYQkkt1pyqS0kkchV0ymc7+e+ZBUzj3UIK3mDMC/6eHWgJtAXBBonexpvagg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792641; c=relaxed/simple;
	bh=/4XWPSb0FBExUXU/MQYd/P3nE1d8c2G0ladYR7KiVh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejI4AG+h9WSbpYgmhpLLZwGJH8TrQwpprx26ruG0oKCEFsZG/D4cb2Szu38+mzkQ9zeexjj3I/+gAKKcgdVpgV05GrdwWSoIsTs6j9r+jJp/j8t6Kl0l3leq9zCErpER+2fq48b/MvyBhtpdjCsNhREeI5EEUyMBFHRr064gUzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIW9tM9B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l7yG4bGo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIW9tM9B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l7yG4bGo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 637202115F;
	Wed,  5 Feb 2025 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738792636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HsHo8dFaL4DkJpAWMBaFNOZLzkThz9YBRSOpnv7mD8M=;
	b=EIW9tM9Bl5IKeT/eQvoP23Mb1TR7vTrPspefpHJ/3Mlww7Xpk61aaia4XMfiz7TCiI6Rkd
	yVDFnoWXjQ1yTdk607HGyEH40L7jWcfR46Yq0xvAwyOqNmu3u8bGruF+IKel5QaA9PgETk
	f19RMdfqt3zWGrsGAPPq8CEYEuJTELU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738792636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HsHo8dFaL4DkJpAWMBaFNOZLzkThz9YBRSOpnv7mD8M=;
	b=l7yG4bGo3LlSP72NprLNgmX7ln9Z0aPjPFMFCxsHIdYssz8AGrUXQDR/3nH+kle2UHWYGU
	QnLwF5jfISLBbHAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738792636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HsHo8dFaL4DkJpAWMBaFNOZLzkThz9YBRSOpnv7mD8M=;
	b=EIW9tM9Bl5IKeT/eQvoP23Mb1TR7vTrPspefpHJ/3Mlww7Xpk61aaia4XMfiz7TCiI6Rkd
	yVDFnoWXjQ1yTdk607HGyEH40L7jWcfR46Yq0xvAwyOqNmu3u8bGruF+IKel5QaA9PgETk
	f19RMdfqt3zWGrsGAPPq8CEYEuJTELU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738792636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HsHo8dFaL4DkJpAWMBaFNOZLzkThz9YBRSOpnv7mD8M=;
	b=l7yG4bGo3LlSP72NprLNgmX7ln9Z0aPjPFMFCxsHIdYssz8AGrUXQDR/3nH+kle2UHWYGU
	QnLwF5jfISLBbHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DEF9139D8;
	Wed,  5 Feb 2025 21:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HLiUCbzeo2eYEQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 05 Feb 2025 21:57:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <petr.vorel@gmail.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH COMMITTED 0/2] IMA test fixes
Date: Wed,  5 Feb 2025 22:57:06 +0100
Message-ID: <20250205215709.1526151-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.30
X-Spam-Flag: NO

From: Petr Vorel <petr.vorel@gmail.com>

Hi Mimi, all,

I fixed 2 regressions I found in the previous implementation.

I'm planning to solve problem with ima_measurements.sh (second commit).

There is also other problem with loading kexec.policy and then running
ima_measurements.sh on SUT with ima_policy=3Dtcb. The latest line in
ascii_runtime_measurements_sha1 was made by ima_kexec.sh:

10 b3c3b7b9da36d5cd992272d3384a783b450ce304 ima-buf sha256:ac8bd67bdaded63b=
e9231c495585fd88edce0812d9b677e1e1e219e2dd3bcd60 key_import_test 3082028630=
8201efa00302010202145be0234ff3adf050349b33
30820286308201efa00302010202145be0234ff3adf050349b33b89465a6aab6e339f7300d0=
6092a864886f70d01010b050030503111300f060355040a0c08686f73746e616d65311b3019=
06035504030c1277686f616d69207369676e696e67206b6579311e301c06092a864886f70d0=
10901160f77686f616d6940686f73746e616d65301e170d3139303832323032323930325a17=
0d3230303832313032323930325a30503111300f060355040a0c08686f73746e616d65311b3=
01906035504030c1277686f616d69207369676e696e67206b6579311e301c06092a864886f7=
0d010901160f77686f616d6940686f73746e616d6530819f300d06092a864886f70d0101010=
50003818d0030818902818100ee96b264072a42888f78a2f9b8198467a3ad97d126f3d1cc1c=
24d23e7185cc743b04d4a54254ca16e1e11ed4450deb98b1f7bb4288424570fabcfc6d5aa93=
a2a14fa2b7835ac877cfea761e5ff414c6ee274eff26f8bd6c484312e56619299acf0dbd224=
b87c3883b66a9393d21af8962458663b0ac1706c63773cd50e8236270203010001a35d305b3=
00c0603551d130101ff04023000300b0603551d0f040403020780301d0603551d0e04160414=
052dd247dc3c36d6d60675fe7ae869790be56171301f0603551d23041830168014e36710f08=
34c973ed94a186fbcd22375b45e2454300d06092a864886f70d01010b050003818100b12fae=
ff1e0e390cfd5eb7140af3b7a653cb49c6ab0a23be24c035331d7600c8f758f9df7fdfc5eeb=
6fec35859203eca0e4f01f9a79a58be630947cb959a52d3f2de96f210d49247c33a6226dc2a=
52ee541069ed3c621f8767fd36a061e9a61adb5d1dd34499d99a1ce6baa496b4f5e2268bfc5=
2c3eea4a6b7b5181f08524aee

# LTP_IMA_LOAD_POLICY=3D1 LTPROOT=3D/opt/ltp PATH=3D"/opt/ltp/testcases/bin=
:$PATH" ima_kexec.sh
ima_kexec 1 TINFO: Running: ima_kexec.sh
ima_kexec 1 TINFO: Tested kernel: Linux ts 6.13.0-2.g0127a37-default #1 SMP=
 PREEMPT_DYNAMIC Thu Jan 23 11:21:55 UTC 2025 (0127a37) x86_64 x86_64 x86_6=
4 GNU/Linux
ima_kexec 1 TINFO: Using /tmp/LTP_ima_kexec.9B6OvGtNZh as tmpdir (tmpfs fil=
esystem)
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
ima_kexec 1 TINFO: Formatting ext3 with opts=3D'/dev/loop0'
ima_kexec 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_k=
exec.9B6OvGtNZh/mntpoint
ima_kexec 1 TINFO: timeout per run is 0h 5m 0s
ima_kexec 1 TINFO: IMA kernel config:
ima_kexec 1 TINFO: CONFIG_IMA=3Dy
ima_kexec 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=3D10
ima_kexec 1 TINFO: CONFIG_IMA_LSM_RULES=3Dy
ima_kexec 1 TINFO: CONFIG_IMA_NG_TEMPLATE=3Dy
ima_kexec 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
ima_kexec 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
ima_kexec 1 TINFO: CONFIG_IMA_DEFAULT_HASH=3D"sha256"
ima_kexec 1 TINFO: CONFIG_IMA_READ_POLICY=3Dy
ima_kexec 1 TINFO: CONFIG_IMA_APPRAISE=3Dy
ima_kexec 1 TINFO: CONFIG_IMA_ARCH_POLICY=3Dy
ima_kexec 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
ima_kexec 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=3Dy
ima_kexec 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
ima_kexec 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
ima_kexec 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dy
ima_kexec 1 TINFO: CONFIG_IMA_DISABLE_HTABLE=3Dy
ima_kexec 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.13.0-2.g0127=
a37-default root=3DUUID=3De36b2366-1af2-4408-903c-1fca82c60f4c splash=3Dsil=
ent video=3D1024x768 plymouth.ignore-serial-consoles console=3DttyS0 consol=
e=3Dtty kernel.softlockup_panic=3D1 resume=3D/dev/disk/by-uuid/c3b865f9-5d5=
b-410e-a6d1-9ebcf721584c mitigations=3Dauto security=3Dapparmor ignore_logl=
evel ima_policy=3Dtcb
ima_kexec 1 TINFO: $TMPDIR is on tmpfs =3D> run on loop device
ima_kexec 1 TINFO: test requires IMA policy:
measure func=3DKEXEC_CMDLINE
ima_kexec 1 TINFO: WARNING: missing required policy content: 'measure func=
=3DKEXEC_CMDLINE'
ima_kexec 1 TINFO: trying to load '/opt/ltp/testcases/data/ima_kexec/kexec.=
policy' policy:
measure func=3DKEXEC_CMDLINE
ima_kexec 1 TINFO: example policy successfully loaded
ima_kexec 1 TINFO: using kernel /boot/vmlinuz-6.13.0-2.g0127a37-default
ima_kexec 1 TINFO: testing kexec -s -l /boot/vmlinuz-6.13.0-2.g0127a37-defa=
ult --reuse-cmdline
ima_kexec 1 TPASS: kexec cmdline was measured correctly
ima_kexec 2 TINFO: testing kexec -s -l /boot/vmlinuz-6.13.0-2.g0127a37-defa=
ult --append=3Dfoo
ima_kexec 2 TPASS: kexec cmdline was measured correctly
ima_kexec 3 TINFO: testing kexec -s -l /boot/vmlinuz-6.13.0-2.g0127a37-defa=
ult --command-line=3Dbar
ima_kexec 3 TPASS: kexec cmdline was measured correctly
ima_kexec 4 TINFO: WARNING: policy loaded via LTP_IMA_LOAD_POLICY=3D1, rebo=
ot recommended
...

# LTPROOT=3D/opt/ltp PATH=3D"/opt/ltp/testcases/bin:$PATH" ima_measurements=
.sh
...
ima_measurements 1 TINFO: booted with IMA policy: tcb
ima_measurements 1 TINFO: verify adding record to the IMA measurement list
ima_measurements 1 TBROK: failed to get algorithm/digest for '/tmp/LTP_ima_=
measurements.GwyPzk6lb8/mntpoint/test.txt'

Kind regards,
Petr

Petr Vorel (2):
  ima_measurements.sh: Fix exit code condition
  ima_setup.sh: Quit the test on unsuitable IMA policy

 .../integrity/ima/tests/ima_measurements.sh        |  4 ++--
 .../security/integrity/ima/tests/ima_setup.sh      | 14 ++++++--------
 2 files changed, 8 insertions(+), 10 deletions(-)


