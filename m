Return-Path: <linux-integrity+bounces-6661-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E52B0CDB1
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F6217BB49
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A52F18B0F;
	Mon, 21 Jul 2025 23:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UO9OVW7Z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D714D70E
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140242; cv=none; b=BhnDAB6DxhQa79SOhCyAH5QLB7+vMJ0GXHV3H84gBdDDgfmlBGvSgcg5kr7vwlBoJdJZ7klwOBU1XQBkYrsABPdX3ijrWP7/wuPgTj9bqnSx3fh671Kd3Odg/Hu3C4uumi05SFbD33OGsOcwUp9/HYz6XnwzGJGiD7SlfgxZetY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140242; c=relaxed/simple;
	bh=9CsL4mPV2dsaGysCfwx3REgaptFlqd7wF9HSrpxwGTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HFpuCpwZ7or1W+acCb0PeALI4dJNYXX8K1f0ictOU7frgc1cCJNZprLqJUBAiXohwmd0cKF8qNJ1kiEQNACHCgfs9ZQroaIKRioGYmQKGFRy7aZzfn+K+IbdNTI+Ll+VI6uYZhZzwrHPeMBORVa5I0CoDvNavz8Sj+BTb2Lc0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UO9OVW7Z; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4abc006bcadso32627891cf.0
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140239; x=1753745039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PinUcNST4KlnEqJlCVOm71QRYIVb44YBVpGpWsCOdq4=;
        b=UO9OVW7Zpi03lqqlsMv0+RCYyqkFwOCBpBQNBZuo4w1PPhrZMUDnLJ60VCEwXEWGn4
         yJtUdgl0xQxDFPbbotnIsZ3H3FdclZxewXSSqcWZ4Cc7NqGMvh8J8MC76KNXNlslWSjk
         312D2PJF9WW7UmsLJMRSlmS9+t8YLya376W6goZy1UhGBfEAuXsFBqIBn8bp1hd0fVyX
         O1kv/PBabeFdeqRjFR+MGnWy2B7BEKQYEx90U7ERhvLU84rW4hNtTghbGOjoRzorDZjD
         aNUwOS5PSZnEkElxftoCQ6HR9emf1TjLl8CgVQMrGWlW9jCoYIhmkTOmsD0OVua3anKT
         hbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140239; x=1753745039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PinUcNST4KlnEqJlCVOm71QRYIVb44YBVpGpWsCOdq4=;
        b=mJ2syKDMoSSYfsNUx8WxHqTt/UTUTbUvhjd0jvKoDlRpoGAHEdUkXwCGbV/2GxWPLp
         dKK9o5ZpCKVSH695urBQzRNHksWc2Zu1jTqN4vOfdexI2DarTy/u7t16l+Yn+kc/TKuU
         ms/TsImpiEPJVandmZdSBl9MStxF7vHp0IEr4rSnjBaqbXGtARmuGi3IfRpLt1sl+P6n
         /YiyjB1hz9GakkQucbaCJyLJWIgrrfddnG97ogO4vJcVhDe6Y99U+H98yUBu9dko0aSP
         cwERlTYz1/iRLxYUvDMOHTwulD1yI79yn7BYyNYtJ74zhz1c8kWv+NpcYCmpkCGo5ZUy
         feSg==
X-Forwarded-Encrypted: i=1; AJvYcCVZkFfO7dEwzhkEeFGOxGPN2I7s6I2eL28F/WIUFPaaWWOPnOX5/tqoua8KiiMpMPJg2RMm6UVvQn/0uqKPYEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+1uB6AcW1U1NSDdI0W15UNahEYVuFR5LCVFMLTgH2Z8K9sI2
	qVmJUKpbfd7H00I0u6eadFn5PnqPjiT5tYFGa7o172qncO2Oormy5/jRslvhjFGjTQ==
X-Gm-Gg: ASbGncteIrEU4oBGoLsCkqqr2uo7rLBZyLf0XhknvuF1clQmBDtLLxTi47/A5tGPDql
	D4HSTemBCyGYq039YBx+L9XlA85FgJYBpiPxVKinQiwPnrSlvJ9pDYGIK8EeJ7yjEevFFlq+BBr
	Be7gFmJGdNwiSWE06kuugfOW8J+ppT60Xr7vcCitOkgItMletx5CfTSOjofrrMjP64O2YHMs7hH
	S7neiKdjottPv4BBBDC4UTLZ4xOjVZuFZ6b4KejsarZyDpzRTnzjdiVnnIzkRmhlnaKow24jSl0
	pc3LHx3BzZ5JSV1BaOIx2kwkUG5VIgafCf7qVpP7LIug+9gLP+7TsI0P7MPnW1Tlf8dkeKe3JzI
	ZsqQqFaKYwUQEJa69troL5BHHNx99+T0FkoOgdQEJd7+VbleGj5l0i3PNu+IZhrl+it6cO7GMPD
	mfOg==
X-Google-Smtp-Source: AGHT+IHhL7W7Ne/UrCbwfq2tmToqJK+MeGR34jdUxqqdzAQ6wsDDhovNS1Ak/vsPos7zAwiL0yYpTg==
X-Received: by 2002:ac8:5e06:0:b0:4a9:8685:1e92 with SMTP id d75a77b69052e-4ab90b1b83bmr311439841cf.34.1753140238908;
        Mon, 21 Jul 2025 16:23:58 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb49802efsm46996491cf.7.2025.07.21.16.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:23:58 -0700 (PDT)
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
Subject: [RFC PATCH v2 0/34] Rework the LSM initialization
Date: Mon, 21 Jul 2025 19:21:03 -0400
Message-ID: <20250721232142.77224-36-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It's taken a few months to prepare the second RFC for posting, mostly
because of the sorry state of the first RFC, although as discussed
earlier, there was a reason for that.  There is a CHANGELOG below with
an itemized list of the changes between RFC/v1 and this posting, but
you can summarize it into three basic things: adding proper commit
descriptions, decomposing some of the uglier patches into smaller
coherent patches that make more sense, and dropping the subject/object
counting code as Casey found a different approach that fits his needs.
I've added the ACKs/Reviewed-by/etc. tags from the first posting, but
left some off as the associated patches changed enough that I felt it
was no longer responsible to include them.  Additional review is always
welcome and encouraged.

The RFC/v1 patchset is linked below, the cover letter provides some
background and motivation for this series which still applies.

https://lore.kernel.org/linux-security-module/20250409185019.238841-31-paul@paul-moore.com/

CHANGELOG
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
Paul Moore (34):
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
      ima,evm: move initcalls to the LSM framework
      selinux: move initcalls to the LSM framework
      lsm: consolidate all of the LSM framework initcalls
      lsm: add a LSM_STARTED_ALL notification event

 include/linux/lsm_hooks.h              |   67 +-
 include/linux/security.h               |    3 
 security/Makefile                      |    2 
 security/apparmor/apparmorfs.c         |    4 
 security/apparmor/crypto.c             |    4 
 security/apparmor/include/apparmorfs.h |    2 
 security/apparmor/include/crypto.h     |    1 
 security/apparmor/lsm.c                |   11 
 security/bpf/hooks.c                   |    2 
 security/commoncap.c                   |    2 
 security/inode.c                       |   62 ++
 security/integrity/Makefile            |    2 
 security/integrity/evm/evm_main.c      |    8 
 security/integrity/iint.c              |    4 
 security/integrity/ima/ima_main.c      |    8 
 security/integrity/initcalls.c         |   41 +
 security/integrity/initcalls.h         |   13 
 security/ipe/fs.c                      |    4 
 security/ipe/ipe.c                     |    3 
 security/ipe/ipe.h                     |    2 
 security/landlock/setup.c              |    2 
 security/loadpin/loadpin.c             |   15 
 security/lockdown/lockdown.c           |    5 
 security/lsm.h                         |   42 +
 security/lsm_init.c                    |  557 ++++++++++++++++++++++
 security/lsm_notifier.c                |   31 +
 security/lsm_syscalls.c                |    2 
 security/min_addr.c                    |    5 
 security/safesetid/lsm.c               |    3 
 security/safesetid/lsm.h               |    2 
 security/safesetid/securityfs.c        |    3 
 security/security.c                    |  617 +------------------------
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
 security/smack/smack.h                 |    7 
 security/smack/smack_lsm.c             |   11 
 security/smack/smack_netfilter.c       |    4 
 security/smack/smackfs.c               |    4 
 security/tomoyo/common.h               |    2 
 security/tomoyo/securityfs_if.c        |    4 
 security/tomoyo/tomoyo.c               |    3 
 security/yama/yama_lsm.c               |    2 
 52 files changed, 1012 insertions(+), 703 deletions(-)


