Return-Path: <linux-integrity+bounces-6818-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE1B27247
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175311CC77CF
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458B2281357;
	Thu, 14 Aug 2025 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AogRvOMz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB4F245023
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212045; cv=none; b=DRF8vttC3sXq3RhvJJP9QWOvpHo/Z+L/6Ot2nFBYFRVxs7xTQZp/ppygP6njvXGIBnYmIK5U7bMjdBn3Wlkab6Abuyqf7qVF5FXPEgv88PkdkE+ZS7ait1VggHAQv7NT3DTdgtLYduFUBnH+qFiV7jJBy5CarHBsWeu2pKboU9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212045; c=relaxed/simple;
	bh=lPdhiCA/2A43VbIVwb+6dc6qvHinv/k9x8LvcHDmb0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nmWYRw93nOR2fz9htdR5glVs8YrNHG2E+SIsG+tBXGq+Hy3yGFF+0GotXMnZQVFML5cal3h5WRTKbd0eAJUsysNdqLr128cz7ITObU/A64zbEbB+AWRUFIdJn5JuvyaLu+8NlNPyiCxh4G7ha/JzJ3TJjuzybrf31/t/wHiMcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AogRvOMz; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b109c4af9eso13203131cf.3
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212041; x=1755816841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rU+UOhNaqwsjYUe9zCIc66XJqDaw1SHKCGrAl1D5PcE=;
        b=AogRvOMzaFUZ51nWudmhtAvLKQCPMxqJUq+rBRtFaD2riJZxFdRHldR2u/TgsOUSf/
         Kx7zSQQ4429F+1g88MMVWsnzgE5aEjKFmLiVOiARaJmci/9GfiUKf7nize1TPAZSs90h
         KD3To7XCDJSUGXCsSjGyjrJh55+6ZbJVj6AmDY3MVqjWGolPJ/3aEckmxKv+++Pr7RyJ
         rsG7WdOXGb8P2Di//vFkJP3oDMugQ8Tfu1VKnnDqQLpbsFGAR0pO/Sv7n0nTdsVa+BFj
         FNChCiWMkjapDGL2clII37p0oM+d6Qb1nJVJPdcPPBXwAsYuFzH0qEmBOmBeIcZDPXw8
         bYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212041; x=1755816841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rU+UOhNaqwsjYUe9zCIc66XJqDaw1SHKCGrAl1D5PcE=;
        b=VLKu6VvYxZAQZ4v21gfYlq4F2Tz4ssjPiE879ZkgR1ImcP26DOOZP/QNcQjtMMLBoE
         3PnbzUFw6bQ6BXgThX3KV0xfYUQWnzGQOIoKDBoI9TspShOKlnwY4qXSsSUbXG44enzK
         U5MyazDoeBTIIECBjaL2LRpioZ/lGcirNM8veBrt7EBP6UsOv9W1EvfnUUUnx094BI6q
         bavXxOQEwpOicmSB9RrL7+smbkPdAcazga2vVc1tb9RbKtgCOgwFnoO3L/d78ogD21ZV
         c0Wn9Bfn/l5HITY4a79eWnual+Id1DISoAVbhRY8OjGBpPGCZ3SbcLYEuSlJj/yMWupa
         hBbA==
X-Forwarded-Encrypted: i=1; AJvYcCV9zsdxorsg0NX8vk4eF167Ukg5mZpwlL4y+RVyp6k4snyKjnwFRwVCxc9OzbQMwwFf6OdjoenpTf+c004R2+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrSVSGGEgK0tTreHzH7VKXlgCUFxAtgpD5n/JckdMbLKT6l/TQ
	epoQDF3MLt+XbpOvkH2xAkuJeI+RqtcPd0XabsI5Xc08dxo4SPQTjAy5I5ug59qg3A==
X-Gm-Gg: ASbGncuj1kFBWX730dtvI2o2GqEZj+xRHJ4YiyNtjGzzZxkzy2X81xmueUv+FaVNfB0
	q3Qr1D386g/uZ/abv0K+fgtmMg6HjdOLBkiPN+NQKuV+QfRqbL55G/RdTJSOM6l2xNbCkJPajI+
	gbIlat/brLKN4Lv4AiabXTh2yjHyDdtjr4yvgRCQQAwvh69Xlno6DMxlMzNgWc/SSOBJZ2C8UHk
	jDmg2BZxGENoszLjhf+xn6vddwrFlSL/hi3aHj8FenNESbt/HlsGpL+3ealcUXVBKDG42UeSVa3
	epJ+SD2uBTDOtxX8wLEaoxXo+k3VdGWK1/9P4S+hkvKXq3pvchhdR+PNeOUgfAdHQCE1X2IezgQ
	Fuf0n9aIiXCjfkW3pNoIano39ALpos6VgahaMGzbWSclXGHVnBWl5xeuaafhQVMOdorU=
X-Google-Smtp-Source: AGHT+IEjObLWGd1F0gHvu1/FHumZZNzME/HV+XYLewREMJxt9Y3k5V3pQZrwrK7pJHvmnr4LC13rqQ==
X-Received: by 2002:a05:6214:5013:b0:709:dff6:9b8e with SMTP id 6a1803df08f44-70af5ccd897mr83782626d6.36.1755212041097;
        Thu, 14 Aug 2025 15:54:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70adc1cd165sm19419346d6.8.2025.08.14.15.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:00 -0700 (PDT)
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
Subject: [RFC PATCH v3 0/34] Rework the LSM initialization
Date: Thu, 14 Aug 2025 18:50:09 -0400
Message-ID: <20250814225159.275901-36-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The third revision of the LSM initialization rework patchset.  While
there was a good deal of change between RFC/v1 and RFC/v2, the number
of changes in the v3 revision are relatively minor; I think the biggest
change is simply bringing it up to date with the current lsm/dev branch.

Please take a look if you haven't already, and to my fellow LSM
maintainers, please focus on the patch associated with your LSM and
either send me an ACK or reply back with the changes you would like to
see before this is merged.  I think we're in a good place with this
patchset, and I'd like to get this merged during this dev cycle if
possible.

The RFC/v2 patchset:
https://lore.kernel.org/linux-security-module/20250721232142.77224-36-paul@paul-moore.com/

The RFC/v1 patchset is below, the cover letter provides some background
and motivation for this series which still applies:
https://lore.kernel.org/linux-security-module/20250409185019.238841-31-paul@paul-moore.com/

CHANGELOG
v3:
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
 security/inode.c                       |   62 ++
 security/integrity/Makefile            |    2 
 security/integrity/evm/evm_main.c      |    8 
 security/integrity/iint.c              |    4 
 security/integrity/ima/ima_main.c      |    8 
 security/integrity/initcalls.c         |   41 +
 security/integrity/initcalls.h         |   28 +
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
 52 files changed, 1043 insertions(+), 711 deletions(-)


