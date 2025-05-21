Return-Path: <linux-integrity+bounces-6280-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3E6ABF722
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED123188C16F
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414821925BC;
	Wed, 21 May 2025 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="gt0H83Lx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACFB16C850;
	Wed, 21 May 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836367; cv=none; b=lQQ4Pgm0UipUlmThtsMnyQBFBtQ2D1l9ToBRBLImdXVGZKjmk1vxK4Pfm9B+7FDGSEoAm5YOZ0DdSK1WaLAK3V1wDlIylWiU78KquU3rtmgtqogormGUEzAPnKzbQHjHQuj4wGpVU2tFJR/+ZvW7G4N0bUAJHnbOncBmeCqNbHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836367; c=relaxed/simple;
	bh=pz6RyQBVVgDU7dGupqoILiF4QPhslnN4CNI6Hc2AExQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npJ82W7k+Xzk0LP3sPfwAnuGo8XtIuCo3SLrcVmV2ztA6H7+jRTFgK47RWPU+BrZRbRualM5OKmwHVktxEhdiy9XQC/ry6dzlxPreGLl069a8DdCl0iNsliVvs/7sLzxBaF1F8Q9x8ie000ytw2eHKejhpwc8o6HI2BaYzCjHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=gt0H83Lx; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from localhost.localdomain (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id C637110821F2;
	Wed, 21 May 2025 14:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747836102;
	bh=pz6RyQBVVgDU7dGupqoILiF4QPhslnN4CNI6Hc2AExQ=;
	h=From:To:Cc:Subject:Date;
	b=gt0H83Lx7o+QmrtB1uJqNXg2piq0/3EEuklENZGp+w87V8+Bh7mE2STuikIhjKQKr
	 Tg9pVTKWsUUaTKzW+l6aDS13aAHPoOYORjQZJZmF/sqHCe8r67SjjfqTYwpvgx7+91
	 cMts6qDw7/MsWnGmrnuWYEvWvWokQAuOgCjUZmXKJpwgrMmFMDmMJkYVioNJ2wjOKg
	 o0A9bJkY6if/fcyyIJhftYNtW5cjvRzNtZRK2oa4W08veDml7w5K4qPplCI/AplOwg
	 7E4ovwEV6WmX8VAQhDIicZ6P8RXvcm2QQlblZM1Xs0KOpvJbJSomT4K3HklWVI869O
	 8Wt3WILALz4Sw==
From: Simon THOBY <git@nightmared.fr>
To: linux-security-module@vger.kernel.org
Cc: Simon THOBY <git@nightmared.fr>,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH 0/9] Introducing the Loadpol LSM
Date: Wed, 21 May 2025 16:01:04 +0200
Message-ID: <20250521140121.591482-1-git@nightmared.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC patch series aims at discussing the interest of a mechanism
that could restrict which modules are loaded at runtime.

Motivation
==========

In my experience, there is three main classes of kernel users.
On the one hand, some entities (companies or individuals) determine the exact set
of features they need, and recompile the kernel to match these needs (this is true
e.g. of cloud vendors, many security products, appliances, etc.). These users
can finely choose which kernel modules are available on their kernels, because
they know beforehand the exact use case, and they (mostly) control the software
and hardware stack.
On the other end of that spectrum, many entities use off-the-shelf distributions
with little to no further hardening (I believe this is the case of >90% of companies).
They don't really care about the presence of modules they may not need,
so all is well.
Finally, somewhere in the middle there are entitites that want to have some
control over what kernel modules are allowed on a system, but without the bandwith
of building and distributing internally their own kernel (because it would require
a dedicated team to keep ahead of the frequent updates, and because the added
value of that team is hard to justify). These entities will often use
off-the-shelf distributions, but they often miss the appropriate knobs to
be able to tweak the system in order to reach their desired security
level. In the particular case of kernel modules, Linux is very binary on
that point: either you allow the loading of any signed kernel module
(kernel.modules_disabled=0) or you completely disallow the loading of modules
(kernel.modules_disabled=1).
Note: there is also secure_insmod for SELinux, but it is a binary option too.

However these users do not want to trust all the kernel modules present
in the distribution packages (to reduce the attack surface, and/or for compliance
reasons).
They want to collate a list of kernel modules required to support their hardware
and software needs, and then to distribute a policy allowing these exact modules,
and blocking the rest.

One big example that comes to my mind is security software, because these finicky
beasts often come with a kernel module that can only be loaded once the
corresponding userland part has started, so very late in the boot process.
In addition, this type of module must be unloaded/reloaded when performing updates.
This is why loading all these modules at boot and then disabling the load of
further modules (via the kernel.modules_disabled sysctl) is not
sufficient.

Implementation
==============

This patch RFC builds a small LSM that can be configured at runtime (in
a practical setup, it would be loaded inside the - signed and verified -
initramfs), and locked to disallow further modifications of the policy.

This is loosely based on the policy mechanism of the IMA subsystem,
which was a great source of inspiration.
A new LSM hook is introduced to decide on a module load if the module
should be allowed or not). When called, the LSM iterates over its policy
and allow the module if a match associated with the ALLOW action is found.
A securityfs file is created to read the policy (using `seq_file` iterators) and update it.
The policy itself is very simple (two keywords to match modules, one
keyword to determine the action to take, and that's about it).
Finally, a sysctl entry exists to lock the policy in its current state.

Questions
=========

Do you believe that such a mechanism would be valuable?
And if not, do you have an idea of alternatives that users could combine to 
achieve the same results?

On an implementation detail, to determine if a module load request comes from
the kernel (instead of a user-initiated load), I currently do something
like `if (current->parent->flags & PF_WQ_WORKER))`. Is that a proper way
to determine that the current load is the consequence of a call to
`request_module`, and is that not overly broad (could this match
requests that are - in the end - user-initiated)?

Thank you for your consideration,
Have a nice day,
Simon

Simon THOBY (9):
  LSM: Introduce a new hook: security_kernel_module_load
  Introduce a new LSM: loadpol
  Loadpol LSM: filter kernel module request according to the policy
  Loadpol LSM: add a file in securityfs to read/modify the policy
  Loadpol LSM: add a sysctl to lock the policy
  Loadpol LSM: emit an audit log
  module: expose the list of blacklisted modules
  Loadpol LSM: include the blacklisted kernel modules in the policy
  Loadpol LSM: add a minimal documentation

 Documentation/admin-guide/LSM/Loadpol.rst |  81 ++++++
 Documentation/admin-guide/LSM/index.rst   |   1 +
 include/linux/lsm_count.h                 |   7 +
 include/linux/lsm_hook_defs.h             |   1 +
 include/linux/module.h                    |   4 +
 include/linux/security.h                  |   6 +
 include/uapi/linux/audit.h                |   1 +
 include/uapi/linux/lsm.h                  |   1 +
 kernel/module/main.c                      |   9 +
 security/Kconfig                          |   1 +
 security/Makefile                         |   1 +
 security/loadpol/Kconfig                  |  12 +
 security/loadpol/Makefile                 |   1 +
 security/loadpol/loadpol.c                |  76 ++++++
 security/loadpol/loadpol.h                |  43 +++
 security/loadpol/loadpol_fs.c             | 139 ++++++++++
 security/loadpol/loadpol_policy.c         | 311 ++++++++++++++++++++++
 security/security.c                       |  14 +
 18 files changed, 709 insertions(+)
 create mode 100644 Documentation/admin-guide/LSM/Loadpol.rst
 create mode 100644 security/loadpol/Kconfig
 create mode 100644 security/loadpol/Makefile
 create mode 100644 security/loadpol/loadpol.c
 create mode 100644 security/loadpol/loadpol.h
 create mode 100644 security/loadpol/loadpol_fs.c
 create mode 100644 security/loadpol/loadpol_policy.c

-- 
2.49.0


