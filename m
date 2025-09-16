Return-Path: <linux-integrity+bounces-7105-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685F4B7D288
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AC452615E
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4C429B8DD;
	Tue, 16 Sep 2025 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W3sKM3f3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEA29A9E9
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060816; cv=none; b=QSz3fHUllzCMRmc2O8IOsI3RY/XxfHLKVTvQdWAZiEHGt8NFMTWYpUVr4PtZTMl2H3y5b21e8o0rLjU0N6v7KN1JBnMBrZy6nbi6nGCt61NxSPgy3mmuRg/whedgH/3leMreywnwKsiRfWkdVFVGuFLSCp7tsKtMXL/EKQ4rKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060816; c=relaxed/simple;
	bh=KEKoazf+RdgvXOwdy/j1s3l2Jx3MEp0aLYvpEDzfO68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sqFTPw9TG9Ac/Qrh0KGdOfWeOWDgGyFobD1OAJYTOV3mWSh0O133zUaEQuZLtlI+tmApDNk2HdzG6RKOv/GRDUNZB5TCk35R5DeWMD5YT0k7Z9HubucxBYKdRZGOu8Eo82yb5TCoUf0YFRtrhwfPO/ccHnpNg1NFcy6EZjLknTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W3sKM3f3; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109c6b9fcso46572841cf.3
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060814; x=1758665614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ou8HM7+FvpfjRvFRWjxB1s6gl/EzXkcqrmhBZWUvpNk=;
        b=W3sKM3f3I2292bnBS3/OIz8GwkscYTVDCUuz/4c4tgj2ZXG+EdDUWCsNUliQ69EYAe
         QEMvtcxYy+ycjhTYZmRlryKBsM9lJW6BWKAxSZz3w2mFZFAVeU1l1UxHCfl2RbXiQbEF
         6kRTHm3/3/clbcYFaJalOr9+aE7KY6QJEaaO3NzOEtJCtntRxrkaMVEK6X7beaiD2E+O
         sIW/EeGmrNzIgigc90DU+Xx19qWJH5IJFjnrMc3tjPcZaadViygUqW0cjOe56ncCf86q
         ZXs4LAnRlBQgY4v/xlTSKnVQiKgrlG+AmNTn5ZPSQBG1m4lr6Lkheondnz8j7OnIwYgX
         b7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060814; x=1758665614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ou8HM7+FvpfjRvFRWjxB1s6gl/EzXkcqrmhBZWUvpNk=;
        b=Oj8ufMNb/dh3oRVTt/V7knxjuhnjPnKW8K0+jEoKw4yGq2Rv8Ko7LYEq5saiVFMGDK
         kt9yojDkBeFAUhjeITPx1OrxoGMlaZLu+qEWY1yeMm4eHTXyctvun1iLeCgA/gSg1Y8+
         SwekkHX+850jeFWD4oVxZwxXLFjWs1lPKFcvynzeh/0sW7wvMIe3qmZjwKP2WTXvq/Wj
         8aE7zty9UrrHtbwVSSkc5ZqLpp0Wsq9PGNZHQKN7mGsWR2iyWhmBtw8Zac5r9HSSzEx9
         MZSPJDNnmPVvCHpRMRBWFWf/Ezay3Agjle3Rz8bR4EMT1cPjdQTsHzuR37C/1DGo5Ozs
         RwNw==
X-Forwarded-Encrypted: i=1; AJvYcCUTupW2W/L0SVuwAahYfPZnaMhBHzOTkNyiBfAd2X5112gXap9mjaJT8AMGwcCEZc+nMRduyNs5VBXmYsw+w+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9bKKQ3WsligHjVhduhBqMsIPoYmH+eYHAO4IxteCcj5dtkMS
	uFja4vqSctoxgGVgi0XltZoNMrKO1B8pP2x+Q8yt+0wfxRzoBNy11SIpS3sjPbRZuw==
X-Gm-Gg: ASbGnctFMHHNeUenrGlPB42IUGN3zPN499nwZfHjEGiAfiYjX66m/2yGqeu7Nnr2GBT
	qt52+cAployGod9N6tPXFPaSc85dnie85JbdtNL3gI/tKroG9h8WuuWUyaVxR+HN04ec60o5sSc
	YpPHUpFhGGZF9zcTniWoy/nK2bhqgKigPoM9gfyVRX67mGnyZAs6ILTwjnCrguxuIGJw7drkGg9
	KRkJspJPUOvf4sGPrUYta0Rx0wx+5q/LvDhj76tu7Zw4u0q941WkCLWX73XU23quU28TIj86wOH
	41eHIxbNYUO7rxeFRoT0vPe5dSHP4bkD6JilGs7QDjVULZb5sqLf1YzHjDTP9h+hu/iTHtutRqu
	/4uMHsjwxzp+NyJxUgbx1rn0U6pKlokuOiRrBfNiCc5AAyAtP+Iqprz21XG62sk9/uXnn
X-Google-Smtp-Source: AGHT+IGSeycXTJmU+LVCeOj0BwbvoSahcrD2iBEepqk9pDoC1WBPQ8AwrQa54YUYw62HRI2HbFD92g==
X-Received: by 2002:ac8:7f04:0:b0:4b7:a434:adab with SMTP id d75a77b69052e-4ba671e6531mr1001801cf.28.1758060813626;
        Tue, 16 Sep 2025 15:13:33 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820cec300a4sm1000810985a.57.2025.09.16.15.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:32 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v4 0/34] Rework the LSM initialization
Date: Tue, 16 Sep 2025 18:03:27 -0400
Message-ID: <20250916220355.252592-36-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the fourth revision of the LSM initialization rework patchset.
The number of changes between this revision and the last are limited to
a rework of the lsm_read() function and the replacement of my IMA/EVM
patch with one from Roberto; relatively minor things given the scope of
the patchset.

I've run the v4 patchset through some basic testing today and everything
looks okay to me; I'll continue to play with it, but I wanted to get this
out onto the list sooner rather than later.  Assuming Mimi is okay with
Roberto's patch, and no other issues are found, I would expect this to go
into the LSM tree after the upcoming merge window closes.

For those of you having problems pulling this patchset into your own
local trees for review/testing, this patchset can be found in the
working-lsm_init_rework branch of the main LSM tree:
https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/log/?h=working-lsm_init_rework

The RFC/v3 patchset:
https://lore.kernel.org/linux-security-module/20250814225159.275901-36-paul@paul-moore.com/

The RFC/v2 patchset:
https://lore.kernel.org/linux-security-module/20250721232142.77224-36-paul@paul-moore.com/

The RFC/v1 patchset is below, the cover letter provides some background
and motivation for this series which still applies:
https://lore.kernel.org/linux-security-module/20250409185019.238841-31-paul@paul-moore.com/

CHANGELOG
v4:
- reworked the lsm_read() function (John, Roberto, Tetsuo)
- replaced the IMA/EVM patch with one from Roberto
RFC/v3:
- rebased to lsm/dev branch
- fixed IMA/EVM initcall comment (Roberto)
- fixed CONFIG_IMA and CONFIG_EVM problems (Nicolas, Roberto)
- fixed CONFIG_SECURITY_SMACK_NETFILTER problems (Roberto)
- fixed the IMA/EVM header file include macro protections
- fixed an off-by-one string length issue in lsm_read() (Casey)
RFC/v2:
- rename lsm_prep_single() to lsm_prepare()
- drop the lsm_prop counting patch
- drop the platform_certs changes from the IMA/EVM patch (Mimi)
- split/reorder anough patches in the patchset that I lost track
- added missing function comment blocks in the SELinux patches
- split patch 04/29 into smaller patches (Kees)
- fix an LSM list output problem in an intermediate patch (Kees)
- preserve the "lsm_active_cnt" variable name (Casey)
- cache the lsm_read() string (Kees)
- squashed, split, and reordered the enabled/ordering patches
- reworked the Smack patch (Casey)
- conditionalized the SELinux IB init code (Stephen)
- fixed missing Smack "__init" annotation (Fan)
- fixed a potential unused variable warning in IMA/EVM (John)
- fixed the placeholder commit descriptions (various)
RFC/v1:
- initial version

--
Paul Moore (33):
      lsm: split the notifier code out into lsm_notifier.c
      lsm: split the init code out into lsm_init.c
      lsm: consolidate lsm_allowed() and prepare_lsm() into
           lsm_prepare()
      lsm: introduce looping macros for the initialization code
      lsm: integrate report_lsm_order() code into caller
      lsm: integrate lsm_early_cred() and lsm_early_task() into caller
      lsm: rename ordered_lsm_init() to lsm_init_ordered()
      lsm: replace the name field with a pointer to the lsm_id struct
      lsm: rename the lsm order variables for consistency
      lsm: rework lsm_active_cnt and lsm_idlist[]
      lsm: get rid of the lsm_names list and do some cleanup
      lsm: rework the LSM enable/disable setter/getter functions
      lsm: rename exists_ordered_lsm() to lsm_order_exists()
      lsm: rename/rework append_ordered_lsm() into lsm_order_append()
      lsm: rename/rework ordered_lsm_parse() to lsm_order_parse()
      lsm: cleanup the LSM blob size code
      lsm: cleanup initialize_lsm() and rename to lsm_init_single()
      lsm: fold lsm_init_ordered() into security_init()
      lsm: add/tweak function header comment blocks in lsm_init.c
      lsm: cleanup the debug and console output in lsm_init.c
      lsm: output available LSMs when debugging
      lsm: group lsm_order_parse() with the other lsm_order_*()
           functions
      lsm: introduce an initcall mechanism into the LSM framework
      loadpin: move initcalls to the LSM framework
      ipe: move initcalls to the LSM framework
      smack: move initcalls to the LSM framework
      tomoyo: move initcalls to the LSM framework
      safesetid: move initcalls to the LSM framework
      apparmor: move initcalls to the LSM framework
      lockdown: move initcalls to the LSM framework
      selinux: move initcalls to the LSM framework
      lsm: consolidate all of the LSM framework initcalls
      lsm: add a LSM_STARTED_ALL notification event

Roberto Sassu (1):
      ima,evm: move initcalls to the LSM framework

 include/linux/lsm_hooks.h              |   73 +-
 include/linux/security.h               |    3 
 security/Makefile                      |    2 
 security/apparmor/apparmorfs.c         |    4 
 security/apparmor/crypto.c             |    3 
 security/apparmor/include/apparmorfs.h |    2 
 security/apparmor/include/crypto.h     |    1 
 security/apparmor/lsm.c                |   11 
 security/bpf/hooks.c                   |    2 
 security/commoncap.c                   |    2 
 security/inode.c                       |   46 +
 security/integrity/evm/evm_main.c      |    5 
 security/integrity/evm/evm_secfs.c     |   11 
 security/integrity/iint.c              |   14 
 security/integrity/ima/ima_fs.c        |   11 
 security/integrity/ima/ima_main.c      |    6 
 security/integrity/integrity.h         |    2 
 security/ipe/fs.c                      |    4 
 security/ipe/ipe.c                     |    3 
 security/ipe/ipe.h                     |    2 
 security/landlock/setup.c              |    2 
 security/loadpin/loadpin.c             |   15 
 security/lockdown/lockdown.c           |    5 
 security/lsm.h                         |   42 +
 security/lsm_init.c                    |  563 ++++++++++++++++++++++
 security/lsm_notifier.c                |   31 +
 security/lsm_syscalls.c                |    2 
 security/min_addr.c                    |    5 
 security/safesetid/lsm.c               |    3 
 security/safesetid/lsm.h               |    2 
 security/safesetid/securityfs.c        |    3 
 security/security.c                    |  623 +------------------------
 security/selinux/Makefile              |    2 
 security/selinux/hooks.c               |   11 
 security/selinux/ibpkey.c              |    5 
 security/selinux/include/audit.h       |    9 
 security/selinux/include/initcalls.h   |   19 
 security/selinux/initcalls.c           |   52 ++
 security/selinux/netif.c               |    5 
 security/selinux/netlink.c             |    5 
 security/selinux/netnode.c             |    5 
 security/selinux/netport.c             |    5 
 security/selinux/selinuxfs.c           |    5 
 security/selinux/ss/services.c         |   26 -
 security/smack/smack.h                 |   14 
 security/smack/smack_lsm.c             |   11 
 security/smack/smack_netfilter.c       |    4 
 security/smack/smackfs.c               |    4 
 security/tomoyo/common.h               |    2 
 security/tomoyo/securityfs_if.c        |    4 
 security/tomoyo/tomoyo.c               |    3 
 security/yama/yama_lsm.c               |    2 
 52 files changed, 984 insertions(+), 712 deletions(-)


