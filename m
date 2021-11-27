Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5C646004B
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Nov 2021 17:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhK0Qv1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Nov 2021 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhK0Qt1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Nov 2021 11:49:27 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB5C061574
        for <linux-integrity@vger.kernel.org>; Sat, 27 Nov 2021 08:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638031571;
        bh=qTXSjYwIShcIgQm1cWqKlyzsP2MDeDMn1QB43Y4sS60=;
        h=From:To:Subject:Date:Message-Id:From;
        b=MQ7oxs+5IrlPZJhvD9OTS8NpvfYibdV9Zwm0sHT3KHr9ZtztVq9Ehv+jbJtePyR9E
         ILvSKh7bmFNBowhiIFfr41ik2cnSnYbtyG6Ku2uQEzSNMif8O//jY98lS7l5S+Vhw+
         aRAutDeeAwm2v3lrPmlkwkrAykS4MVFzh++0GH7w=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4EC4A128063F;
        Sat, 27 Nov 2021 11:46:11 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mYj7AoHhMH8m; Sat, 27 Nov 2021 11:46:11 -0500 (EST)
Received: from rainbow.int.hansenpartnership.com (unknown [153.66.140.204])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E44461280639;
        Sat, 27 Nov 2021 11:46:09 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     containers@lists.linux.dev, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
Subject: [RFC 0/3] Namespace IMA
Date:   Sat, 27 Nov 2021 16:45:46 +0000
Message-Id: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Over the past five years there have been several attempts to namespace
IMA [1,2,3].  All of them were eventually fairly huge patch series,
which try to solve every issue and potential issue all at once, making
them incredibly difficult to review and highly dependent on an array
of non-IMA features which causes huge upporting difficulty as the
patch progresses.  Given this, I thought we'd try a different way:
introduce a minimal namespacing of IMA and try to build on it in
subsequent patches.

This first patch set namespaces IMA by tying it to the user namespace.
The reason for this is that IMA, at some point, is going to need to do
appraisal in containers and thus ima namespaces are going to require
.ima or _ima keyrings.  Since they keyrings are already namespaced
inside user_ns, adding keyring functionality to a different namespace
is going to be problematic, so I elected to fix the problem by using
the same namespace for IMA and the keyrings.  This decision could
obviously change, but I think given the keyring dependence, we'd need
a good reason to have a different namespace for IMA.

All this patch set does is add a new template 'ima-ns' which includes
the user namespace uuid (added by the first patch) in the IMA log.
Using uuids gives us probabalistically unique identifiers for all
namespaces without having to check them for uniqueness.

Once we have the container being logged, it stands to reason that the
ima inode cache needs to record one event per namespace per inode
instead of the one global event per inode, so if I enter the ima
namespace and execute the same measured command, it will log again
with the new namespace uuid even if the hash is the same:

 > ls
 > grep ls /sys/kernel/security/integrity/ima/ascii_runtime_measurements
10 c70c7b851f83c8c71ee7b508c8468383c0d2c154 ima-ns sha256:1f7f27ef1052e33731c9ff56a36ac3af4437e3f95ad55f6813c320b087b5d356 /usr/bin/ls 6582e360-1354-42b9-a6ef-ee1993d982da
 > unshare --user -r
 # ls
 # exit
 > grep ls /sys/kernel/security/integrity/ima/ascii_runtime_measurements
 10 c70c7b851f83c8c71ee7b508c8468383c0d2c154 ima-ns sha256:1f7f27ef1052e33731c9ff56a36ac3af4437e3f95ad55f6813c320b087b5d356 /usr/bin/ls 6582e360-1354-42b9-a6ef-ee1993d982da
10 144a73d85e9cf999c4abbc99f3c41e9422c8016e ima-ns sha256:1f7f27ef1052e33731c9ff56a36ac3af4437e3f95ad55f6813c320b087b5d356 /usr/bin/ls e496e384-4133-4d57-b93a-1812b83badf2

Note that this namespacing if the iint cache is in the third patch and
could be dropped if there's huge opposition.

Some things to note are that the IMA securityfs entries aren't
virtualized.  This is planned for a follow up patch (so currently the
admin can't even view the ima log in the container).  Everything
that's logged goes through the main IMA log and the physical TPM.
This means that the admin of the physical system can attest to the
log, but the containers would have to trust the admins attestation of
their log pieces.  The initial IMA policy is also inherited from the
physical system and can't currently be changed.

The rough plan of action for follow up patches is

1. Namespace securityfs so container admin can read the IMA files like
   log which would only show entries related to the container (so
   likely only entries of the current and all child user namespaces)
   and policy.

2. Add per namespace policies by writing to the policy file in the
   container.  Obviously implementation of this would have to preserve
   the security of the system, so the new namespace couldn't stop
   logging something the physical host required to be logged, but it
   could add additional classes of things to log.

3. Add the ima keyrings and the ability to appraise inside the container.

There could be other phases beyond this, including possibly optionally
attaching a vtpm to the container to provide local quotes but this
should be need driven.

Some non problems of this approach are:

* The continuous growth of the IMA log.  This is already a problem
  with non-namespaced IMA.  One can argue that the above
  implementation makes the problem worse, but it is unarguable that if
  the problem were solved generally it would no logner be an issue for
  containers.

* attesting to the in-container IMA log.  Given it's being logged
  through the physical TPM, the physical system owner will have to
  publish a mechanism for attesting to particular container entries of
  the log.

[1] https://lore.kernel.org/all/20200818152037.11869-1-krzysztof.struczynski@huawei.com
[2] https://lore.kernel.org/all/20180511144230.75384-1-stefanb@linux.vnet.ibm.com
[3] https://lore.kernel.org/all/1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com

James

---

James Bottomley (3):
  userns: add uuid field
  ima: Namespace IMA
  ima: make the integrity inode cache per namespace

 include/linux/ima.h                       |  14 ++-
 include/linux/user_namespace.h            |   7 ++
 kernel/user.c                             |   2 +
 kernel/user_namespace.c                   |   9 ++
 security/integrity/iint.c                 |   4 +-
 security/integrity/ima/Kconfig            |   6 +-
 security/integrity/ima/Makefile           |   2 +-
 security/integrity/ima/ima.h              |  21 +++-
 security/integrity/ima/ima_api.c          |   7 +-
 security/integrity/ima/ima_main.c         |  21 ++--
 security/integrity/ima/ima_ns.c           | 115 ++++++++++++++++++++++
 security/integrity/ima/ima_policy.c       |   2 +-
 security/integrity/ima/ima_template.c     |   6 +-
 security/integrity/ima/ima_template_lib.c |  26 ++++-
 security/integrity/ima/ima_template_lib.h |   4 +
 security/integrity/integrity.h            |  11 ++-
 16 files changed, 236 insertions(+), 21 deletions(-)
 create mode 100644 security/integrity/ima/ima_ns.c

-- 
2.33.0

