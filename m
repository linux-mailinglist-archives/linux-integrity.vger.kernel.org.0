Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929BF5FE564
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 00:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJMWhJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Oct 2022 18:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJMWhF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Oct 2022 18:37:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA9E112A91
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:36:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pq16so3285158pjb.2
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jQAeNxeJTyn1Cn+RS6Vx/H+Tf8STo7ROWsmXYvM9Qw8=;
        b=SNm7kh5cQEfxOs/f0jz3d4Jijz9U3R0dSyHk83VFHEj3lKztL9+ZZBtOQsrmRusMAP
         vQ7Wb/df4yYUiVKsIpuC2RxcKVugp3kjAvaZcAGdJAQZrPkLvpMiLHd6/6kmsuEVI6mh
         gqPlQNFg+XW8QwdJ3y2wI4e5o3b5PHnLwp3jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQAeNxeJTyn1Cn+RS6Vx/H+Tf8STo7ROWsmXYvM9Qw8=;
        b=HbcvfYq73CRK9SpM+zCv4loOPklxqaKVLr94Ndefh6VFHMwaMZOkwDSQ//3ZPRBssO
         03fPSV9iLkC/I414GzBjS1TgTBi7wuG9XOMUMH5IFVGAfP38TTsAdrHFyE2Tk9lQ05rC
         1vsQFrCA1FztWuW5T1JJqc7NZ7xbmEU611zbIXcUWsYk4g0soEatx1p9s/af/ZMOdSzQ
         swCQ8EJJoVDuUHWwGqw2o0k3zlwxPRmtJFGh8fSafDb5VMgsUEbK64eDqDZqBeJBee+p
         1+p+xhhpK4IXTA0LTCmyrXYDDxn9rbG5IncljYcfvTHNKTZ4FCsYj8yPuDTfs82lIZMY
         GRMw==
X-Gm-Message-State: ACrzQf0JEVerctsxYWTZKMNWhqhUPP+JRiJEvBAGSqYoOB5fJUmC4VZ9
        NSBwa0Db7zdsoMreNRZwtOX3OA==
X-Google-Smtp-Source: AMsMyM6ZfdnI5oenHINzBXChWvwpmJmEPvdgA40CGNTh/nLOZcER/YWKfQ+8lQNZCJAQUX9kvQrv5A==
X-Received: by 2002:a17:902:bd98:b0:182:631b:7dd5 with SMTP id q24-20020a170902bd9800b00182631b7dd5mr1848776pls.165.1665700618483;
        Thu, 13 Oct 2022 15:36:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i3-20020a17090a2a0300b0020a1f091a0asm3685673pjd.55.2022.10.13.15.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:36:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/9] integrity: Move hooks into LSM
Date:   Thu, 13 Oct 2022 15:36:45 -0700
Message-Id: <20221013222702.never.990-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2329; h=from:subject:message-id; bh=Rqb1/7Rmsyt9YO6WJZlgGJd4M6/XeTOUzpcOQEF2HJw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSJMDeaBP2XLSDLNB3r+80mq1j5GFVEDof8xNcCU3 kutSPj6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0iTAwAKCRCJcvTf3G3AJjtxEA CX4on0FfpHi6vw4tRbZo7sYkWND2hfsGJx0dve8cpcdOLP00fga+uc+6ELIMcpIV4W76BKZp8WLZgA 8iz2mvEp+kAtKrO+MymemcX2gWvBNFQ6oqKDJTafK3LuQtVhl6KoYMuTyOYB0ZYFfLU2LZZ0zCABw+ 9xSIjtSrKzKbBLeFvOC66vyTTmwoKUrw+NYgFu+vE2qVK2OOyhy88qAL8YiGt7WRfbUbUKCPkzWSSe Z8zOzGTm8tsJEJUdgV1GBi6YeluCVM1YLQGc8ZDsQJwYsFcDfTxI1MftUBU1O1/4iqcSXVVhJLvcuj iyANrNCCyUlc5suVeGWwJjwBpK2J68zlCkWpMPkcqpvvca8FW2jRJGK9KLgBv4F5yKEvZvVHhkSKSy PrbaBmIqxwaF+N8TI3/d/EO2DOds1yN7OL32SkX8EdV3oLZQJ4hVvhlr4kFZHmUd7pgVwn8Vqv+uK0 UFan4RQ1+I3qkErQAANveVvY5pXtci9ipFe4FGoWoSUTDG1UgUSINTEVskfUOFyB9qoHI36yRNUl2F jqQrqP9+un1/0GisyWHFVg/4yk1APsDuL/bcZfD8mXL28M2fC8F7ih+gObJ65mNiTSlnS/noOYmMur gzjHkQGd9Iy9zVdgXvpuTvJYV/by/kknnK2M4nUw6VwG1HmoDpR9ErQG8zxw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

It's been over 4 years since LSM stack was introduced. The integrity
subsystem is long overdue for moving to this infrastructure. Here's my
first pass at converting integrity and ima (and some of evm) into LSM
hooks. This should be enough of an example to finish evm, and introduce
the missing hooks for both. For example, after this, it looks like ima
only has a couple places it's still doing things outside of the LSM. At
least these stood out:

fs/namei.c:     ima_post_create_tmpfile(mnt_userns, inode);
fs/namei.c:                             ima_post_path_mknod(mnt_userns, dentry);

Mimi, can you please take this series and finish the conversion for
what's missing in ima and evm?

I would also call attention to "175 insertions(+), 240 deletions(-)" --
as expected, this is a net reduction in code.

Thanks!

-Kees

Kees Cook (9):
  integrity: Prepare for having "ima" and "evm" available in "integrity"
    LSM
  security: Move trivial IMA hooks into LSM
  ima: Move xattr hooks into LSM
  ima: Move ima_file_free() into LSM
  LSM: Introduce inode_post_setattr hook
  fs: Introduce file_to_perms() helper
  ima: Move ima_file_check() into LSM
  integrity: Move trivial hooks into LSM
  integrity: Move integrity_inode_get() out of global header

 fs/attr.c                             |  3 +-
 fs/file_table.c                       |  1 -
 fs/namei.c                            |  2 -
 fs/nfsd/vfs.c                         |  6 --
 include/linux/evm.h                   |  6 --
 include/linux/fs.h                    | 22 +++++++
 include/linux/ima.h                   | 87 ---------------------------
 include/linux/integrity.h             | 30 +--------
 include/linux/lsm_hook_defs.h         |  3 +
 security/Kconfig                      | 10 +--
 security/apparmor/include/file.h      | 18 ++----
 security/integrity/evm/evm_main.c     | 14 ++++-
 security/integrity/iint.c             | 28 +++++++--
 security/integrity/ima/ima.h          | 12 ++++
 security/integrity/ima/ima_appraise.c | 21 +++++--
 security/integrity/ima/ima_main.c     | 66 ++++++++++++++------
 security/integrity/integrity.h        |  8 +++
 security/security.c                   | 78 ++++++------------------
 18 files changed, 175 insertions(+), 240 deletions(-)

-- 
2.34.1

