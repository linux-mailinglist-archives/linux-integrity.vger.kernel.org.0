Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E27C12CAF
	for <lists+linux-integrity@lfdr.de>; Fri,  3 May 2019 13:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfECLqw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 May 2019 07:46:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38818 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfECLqv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 May 2019 07:46:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id w11so5654656edl.5;
        Fri, 03 May 2019 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SUzz8Pj0c+WsqXtdVpJDOr7+714Bl6dV3H6hlHSl0LM=;
        b=BLYsTAEQbWzcmkgKtrINtG//3ZRMga0gWmXJLigpWRHQ4USXwWTqw1l8wD0qzh20hD
         JUWYn3ZkWjxkO3haBqi9UEgZM/jGJ4aL284bYTv3yHTW05lXjfANyUaMCCxUVghy2eCL
         iLpfJWRFUZM9wKRYuBwNlEK80YYvdiwcK1atJ47vspLKa6HLVWE+n19owJq/CiSWA5v6
         WjH9Qa/LnMokZmyzka7CrERdr2lXN4c1Q4ItUKc7ttZeUTAAhycVcuzp9EbPny+52X/m
         doMI6moqWm6T+8oSWhSHB6c30bMPctIaTjxqwmV1OyJ/2EaXDWhrEZxBNGVxCfCePzCn
         whIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SUzz8Pj0c+WsqXtdVpJDOr7+714Bl6dV3H6hlHSl0LM=;
        b=bql5bwZvQqeWh7673VRmM4U2mTVgvfDK5kSkoXiG32I0QQrtMhhZBpnw7CKem7owQv
         1U9FHOpyj/FXkwbLr0vyEfSW+iEm1CNFZ1vj/Icc07XgaSWfja8WAQVtVDAvAqLGXw4n
         2ncPyKM3uESdj52zCQzz3uv83Nc3kG93kEgjRRAR5X8RqrBCX/iEtqIUCQZE+LEshVP7
         08UPelbS3F1RBy9oit6D5jOs8OFuOf45Qh5PFlNau8WLL8b57XA5es8JNCTYpC4b8Pa0
         f4XBy76kFk743mlLXqER4lr5KtCcDkBZ9Felf4f3lMiaFoxQPeaAkh6hB1nsUvsTg2MA
         7psg==
X-Gm-Message-State: APjAAAVFXiYpRPlcHLwMh4AeUaDJm3SGzSe6NF6hUQpysd2x2IfAoJiH
        ueZovU70rq5Z3+BldCrHtYLHk8n93Xm4nVavLxs4skT4A8aorg==
X-Google-Smtp-Source: APXvYqzI2yRSX1xo2ruyfnRuglypC4T2+7PoJVl/qekpcw1bEuTrwQXLJp0KS8WKs2z1Ktr2lHiCBJTu5Koglbaa7kc=
X-Received: by 2002:a50:9785:: with SMTP id e5mr7740641edb.94.1556884009023;
 Fri, 03 May 2019 04:46:49 -0700 (PDT)
MIME-Version: 1.0
From:   Elena Reshetova <elena.reshetova@gmail.com>
Date:   Fri, 3 May 2019 14:46:38 +0300
Message-ID: <CALrft9-KhB8WZpZHoyd3uDN-ryX=pnSV6=5QEvZAe2YCV9aBYA@mail.gmail.com>
Subject: [ANNOUNCE][CFP] Linux Security Summit Europe 2019
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
                            ANNOUNCEMENT AND CALL FOR PARTICIPATION
                                LINUX SECURITY SUMMIT EUROPE 2019

                                        31 October =E2=80=93 1 November
                                                Lyon, France
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

DESCRIPTION

The Linux Security Summit (LSS) is a technical forum for collaboration
between Linux developers, researchers, and end users. Its primary aim is to
foster community efforts in analyzing and solving Linux security challenges=
.

This year, for the second time, the Linux Security Summit is going to
be also held in Europe (LSS-EU) in order to facilitate broader participatio=
n
in Linux security development.
Similar to LSS-North America, LSS-EU provides a unique opportunity for to h=
ave
discussions and networking opportunities with key people in the Linux kerne=
l
security community, present your work and ideas and affect the future direc=
tion
of Linux security.

The program committee currently seeks proposals for:

    * Refereed Presentations:
        45 minutes in length.

    * Panel Discussion Topics:
        45 minutes in length.

    * Short Topics:
        30 minutes in total, including at least 10 minutes discussion.

    * BoF Sessions.

    * Tutorials *NEW for 2019*:
        90 minutes in length.
        Tutorial sessions should be focused on advanced Linux security defe=
nse
        topics within areas such as the kernel, compiler, and security-rela=
ted
        libraries. Priority will be given to tutorials created for
this conference.

Topic areas include, but are not limited to:

    * Kernel self-protection
    * Access control
    * Cryptography and key management
    * Integrity control
    * Hardware Security
    * Iot and embedded security
    * Virtualization and containers
    * System-specific system hardening
    * Case studies
    * Security tools
    * Security UX
    * Emerging technologies, threats & techniques

Proposals should be submitted via:
 https://linuxfoundation.smapply.io/prog/lss_eu_2019/

DATES

 * CFP Close: Wednesday , July 31, 2019
 * CFP Notifications: Friday, August 9, 2019
 * Schedule Announced: Monday, August 19, 2019
 * Event: October 31 =E2=80=93 November 1, 2019


WHO SHOULD ATTEND

 We're seeking a diverse range of attendees, and welcome participation by
 people involved in Linux security development, operations, and research.

 The LSS is a unique global event which provides the opportunity to present
 and discuss your work or research with key Linux security community member=
s
 and maintainers. It?s also useful for those who wish to keep up with the
 latest in Linux security development, and to provide input to the
 development process.

WEB SITE

 https://events.linuxfoundation.org/events/linux-security-summit-europe-201=
9/

TWITTER

 For event updates and announcements, follow:

 https://twitter.com/LinuxSecSummit

PROGRAM COMMITTEE

 The program committee for LSS-EU 2019 is:

    * Elena Reshetova, Intel
    * James Morris, Microsoft
    * Serge Hallyn, Cisco
    * Paul Moore, Cisco
    * Stephen Smalley, NSA
    * John Johansen, Canonical
    * Kees Cook, Google
    * Casey Schaufler, Intel
    * Mimi Zohar, IBM
    * David A. Wheeler, Institute for Defense Analyses

The program committee may be contacted as a group via email:
 lss-pc () lists.linuxfoundation.org
