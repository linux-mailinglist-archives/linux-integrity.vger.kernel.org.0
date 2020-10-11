Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888F328A88E
	for <lists+linux-integrity@lfdr.de>; Sun, 11 Oct 2020 19:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgJKRpJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 11 Oct 2020 13:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgJKRpI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Oct 2020 13:45:08 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E4C0613CE;
        Sun, 11 Oct 2020 10:45:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id q26so11979259qtb.5;
        Sun, 11 Oct 2020 10:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=K/LoyPsHfKdi1ZcF54EQc3/yoAQf3NlApRaky4RKPyc=;
        b=C+5/IiiRVGGxoh+Ms5u7ykIDc/PvT2O8zozK5Gr3dfpziSnB40aH++yKtTu8WDhNVl
         hnC5v3J9Go7/tPGhhl4NPMq38QJj69ROAUrkhK7IksDADPFZRQUHp1BT5d2WGS7kRvOi
         5Vaury5XX4AQE6yZhCk+3Cfnoj0WZlI/n2peOBnNoeD3B1w3mpv+x1bXdWmLJJjd8xbz
         G4qQPA/5/O7w5zlHH/EGGjsQ9e0iESScUX2L46Pv9ZMEcGgSIGHaIuTySp9WA7WOamSj
         +FNdyyloyGuh8kDHaJ2DhEBvZjzV45Ebh+snLoO0M8Ay4oM2n6wS1ixU1jIUizN8x2ou
         AFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=K/LoyPsHfKdi1ZcF54EQc3/yoAQf3NlApRaky4RKPyc=;
        b=SqHUu9+jjQSAJE2DCG+BhM0foRyvuqDWiL+z0cG/hPIbqw2Dn+bifkv5Afn3Kvl1i+
         iyjXYhf3SC/EVhb96IBym+7gpdwsso0aKfT92fnDBbdMmiOwtGZjFRU3mjXFpu82J/XB
         XnQj0VBGjtQW6VmGuRJaX/yJ7PpQSIXeFFRPu3OIYNN5/IoGoHfOkdPVCPp75p3503wP
         WZnJVFGsN/oS7+oY3kdeTJKjTuIwaDNUBDFqXJP0uaM5fuuL9hVLqyi112JGytZdEjXL
         F1Rx6NUQYfmb4fwtD7UcF4GNAox12HFqUTj0V3tt77LOLSglc7ssUYe7RzbAsFRxmkrD
         /ocw==
X-Gm-Message-State: AOAM533NqVfU979DIp3VYBXdZm77I6kcKpwjg5AXfoDgLUt+a4ko8Atf
        4Gcq74CaT0fNTgAajKCenw1e7c7fm0wp0lJkSyAcnuNGsqc=
X-Google-Smtp-Source: ABdhPJxuo+aCmgWZsDtGhosoNajO/8pXwJUo3wF2L6USdMnd1zioOSmaG8X/5Byia21t0o1w8QchekFEMJnJOiOVsRo=
X-Received: by 2002:a05:622a:208:: with SMTP id b8mr6950167qtx.101.1602438307044;
 Sun, 11 Oct 2020 10:45:07 -0700 (PDT)
MIME-Version: 1.0
From:   rishi gupta <gupt21@gmail.com>
Date:   Sun, 11 Oct 2020 23:14:54 +0530
Message-ID: <CALUj-gs2-kCX00Pf42kb+fYo0UE6DD6he3z=-Lz8M52-AFFi_Q@mail.gmail.com>
Subject: Does selinux rule needed for .ima keyring access - integrity: Request
 for unknown key 'id:87deb3bf' err -13
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi IMA experts,

Do we need to write any rule for selinux to allow access to key in
.ima keyring for all processes or I am thinking in wrong direction.

"integrity: Request for unknown key 'id:87deb3bf' err -13" is the
error with selinux enabled (kernel is 4.14). Without selinux enabled,
IMA appraisal works fine.
Audit logs:
[10012.824868] type=1800 audit(315974764.149:5729): pid=7511 uid=1001
auid=4294967295 ses=4294967295
subj=system_u:system_r:testd_cm_t:s0-s15:c0.c1023 op="appraise_data"
cause="invalid-signature" comm="sh" name="/sbin/testdaemon"
dev="ubifs" ino=18446 res=0

Output of few commands just in case it is useful:

# keyctl show -x %:.builtin_trusted_keys
Keyring
0x26edf4c7 ---lswrv      0     0  keyring: .builtin_trusted_keys
0x3e65ef00 ---lswrv      0     0   \_ asymmetric: IMA-CA: IMA/EVM
certificate signing key: 20c98dcf771b2a945c0ffd245011118299f90bdf

# keyctl show -x %:.ima
Keyring
0x0e961ca8 ---lswrv      0     0  keyring: .ima
0x2e3011f8 ---lswrv      0     0   \_ asymmetric: ima: signing key:
edc4697e8b77ef2713e491616726090c87deb3bf

/ # cat /proc/keys
02fdee99 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
035ab7c0 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
0439d238 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
04964e3e I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
04da590e I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
054ef37d I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
055154e2 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
06511dd4 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
0761426a I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
0793080e I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
07f495f8 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
082f71d6 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
096dee7c I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
09904799 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
0b87b742 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
0c1b072c I--Q---     3 perm 3f030000     0     0 keyring   _ses: 1
0d02c3ff I--Q---     2 perm 3f030000     0     0 keyring   _ses: 1
0db26b5a I--Q---     8 perm 3f030000     0     0 keyring   _ses: 1
0dc6c62e I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
0e961ca8 I------     1 perm 1f0f0000     0     0 keyring   .ima: 1
0ff12212 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1156ac2d I--Q---    13 perm 3f030000     0     0 keyring   _ses: 1
1252fe6f I--Q---     3 perm 3f030000     0     0 keyring   _ses: 1
1285aef6 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1322fc5e I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
13866397 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
14173f44 I--Q---     2 perm 1f3f0000     0 65534 keyring   _uid.0: empty
14931524 I--Q---     3 perm 3f030000     0     0 keyring   _ses: 1
155502e8 I--Q---     3 perm 3f030000     0     0 keyring   _ses: 1
1604215d I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
16b40b6b I--Q---     4 perm 3f030000     0     0 keyring   _ses: 1
17db30d9 I--Q---     3 perm 3f030000     0     0 keyring   _ses: 1
18ea41e0 I--Q---     5 perm 3f030000     0     0 keyring   _ses: 1
19b92253 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
19eeed3f I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1b89b979 I--Q---     2 perm 3f030000     0     0 keyring   _ses: 1
1c0a573f I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1cd763d5 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1d3caf71 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1d6a3880 I--Q---     2 perm 3f030000     0     0 keyring   _ses: 1
1ddffca9 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1df0c622 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
201c5a37 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2045b3bb I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
20993304 I--Q---     2 perm 3f030000     0     0 keyring   _ses: 1
2154e4a6 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
22f2253f I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
25e97a49 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2665b7b4 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
26edf4c7 I------     1 perm 1f0b0000     0     0 keyring
.builtin_trusted_keys: 1
2798bd15 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
29931371 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2a3853b1 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2cc594f1 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2dc04d98 I--Q---     2 perm 3f030000     0     0 keyring   _ses: 1
2e0e4f06 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2e3011f8 I------     1 perm 1f030000     0     0 asymmetri ima:
signing key: edc4697e8b77ef2713e491616726090c87deb3bf: X509.rsa
87deb3bf []
2e769ee9 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2ebb4809 I--Q---     1 perm 1f3f0000     0 65534 keyring   _uid_ses.0: 1
2fdc0299 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
307f8910 I--Q---     1 perm 3f030000     0     0 keyring   _ses: 1
3384a46f I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
357dd4d1 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
3be9a95e I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
3c3162f6 I--Q---     3 perm 3f030000     0     0 keyring   _ses: 1
3d47a3ab I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
3e65ef00 I------     1 perm 1f030000     0     0 asymmetri IMA-CA:
IMA/EVM certificate signing key:
20c98dcf771b2a945c0ffd245011118299f90bdf: X509.rsa 99f90bdf []
3f625ed4 I--Q---     5 perm 3f030000     0     0 keyring   _ses: 1

Regards.,
Rishi
