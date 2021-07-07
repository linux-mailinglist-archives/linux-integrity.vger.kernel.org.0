Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346203BEEBA
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 20:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhGGSb1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 14:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhGGSb0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 14:31:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F984C061574
        for <linux-integrity@vger.kernel.org>; Wed,  7 Jul 2021 11:28:46 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 37so3229263pgq.0
        for <linux-integrity@vger.kernel.org>; Wed, 07 Jul 2021 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V9yi9fBE98luxTHabJZ+troVoCaFmn1djYpIpyqEL7c=;
        b=bsXugdbCznfhtITD3Xddwyg3wuTQvA3hphEmWDlj/+e33pHAjBT175sKG6/++0PSXQ
         uwrPIDyqpTynIAEpcD5ptGWbDHL0Xs3C5Ol62Jc4P82UIs/lGVf1c8wz/buX/vQaV3fA
         kdHrJkGndGZSWWEk8J0g1TtagJsHSpBJOPW8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V9yi9fBE98luxTHabJZ+troVoCaFmn1djYpIpyqEL7c=;
        b=QKWSEKzWhBDyEOludFGUDx93kJc4vHS75xOWVEgzc2TIppTGTUmlvkU6navDH3yKTF
         +k0T/R1qs4ANj1JmebhO5+LuT2GZJPx/8C+bCbE31I81dv3+bqA9uZ2kX+Jm/vsZDzyZ
         bFqo6Gnl7QbdaPpmNVEb65FgRpc0oZKhwUc4ug0hq+n0VzU2FTeGwWBzd6Ie9PbBBmFt
         W8+9i9XGXjcCod3XM+eEjwuMmntC2Lx8vUrMKT7CtrvqWJjXfaEF0QejmM82UNpbni9p
         R2w/O9yPRe+Hr1snEY4fnYTYoRslO67k7n0RVbUtCpN1c2E1Xs/FxbrgT0Ghv51AWV7T
         9DtA==
X-Gm-Message-State: AOAM53340WvDji3ziEIWHvT0sjWrP0JZm8QYX0Vzl28mvD1rAMLhnT+h
        euUjQ/22cuUY8wLUfndtZcAr3g==
X-Google-Smtp-Source: ABdhPJyRRzZwSxdmuwDmgl3I8vbJefEjENqefGxF9sNahwPdjO/M9KZpaJ/3vaMurxUq8rWe2tsF8Q==
X-Received: by 2002:aa7:98dc:0:b029:31a:7509:2322 with SMTP id e28-20020aa798dc0000b029031a75092322mr23599679pfm.7.1625682525609;
        Wed, 07 Jul 2021 11:28:45 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id h9sm23997882pgn.57.2021.07.07.11.28.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jul 2021 11:28:45 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] tpm: fix ATMEL TPM crash caused by too frequent
 queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20210707092411.onk6ewfmhxj5kf3v@kernel.org>
Date:   Wed, 7 Jul 2021 11:28:35 -0700
Cc:     Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James.Bottomley@hansenpartnership.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <712FD1C1-941C-4ABA-866D-6EA6AFA0FE9F@rubrik.com>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210707043135.33434-1-hao.wu@rubrik.com>
 <20210707092411.onk6ewfmhxj5kf3v@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Jul 7, 2021, at 2:24 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Tue, Jul 06, 2021 at 09:31:35PM -0700, Hao Wu wrote:
>> Since kernel 4.14, there was a commit (9f3fc7bcddcb)
>> fixed the TPM sleep logic from msleep to usleep_range,
>> so that the TPM sleeps exactly with TPM_TIMEOUT (=3D5ms) afterward.
>> Before that fix, msleep(5) actually sleeps for around 15ms.
>=20
> What is TPM sleep logic?
It is about the commit metnioned in the description
`tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic =
drivers`
=
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3

Any better description or terms ?

>=20
> /Jarkko

Hao=
