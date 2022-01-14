Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C209648E34E
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jan 2022 05:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiANEbi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jan 2022 23:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiANEbh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jan 2022 23:31:37 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81251C061574;
        Thu, 13 Jan 2022 20:31:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h1so12231392pls.11;
        Thu, 13 Jan 2022 20:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y3Vea8plG7NdygEVdJpagO9aiMQvkxxFcDl4y17hVgM=;
        b=YWDavPGlHlCkZioKRp2U+66aqRlsrunjaGL4gKYFEtafhyIo/iQudiCKytDDQ8K9rY
         r5i+EfhJl+fCKTQn+rXsUKqLBkhxBpdEPawyOhAv4oWMbrejPSFGUoPXO+4CXP9m5NHy
         FbiUypYUmRMscR5MTK4b1T3CwUiPaV4q/w4cMxId61VDDwp5HzJHJS08j8ns8vxhSpL7
         PKLiFwlD9uEQ0gYciGNs/qjstn1Qyf0YwZCNcbK31fLg0MVPpUjiIUsq2iDF2zm5H3PN
         CgoSAQ5YOMkDdFu7tAQr3V4KkwnYH6TalT2WimukYB4zVEmCWdYVXxLtrDXqjWtyzzlg
         +zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y3Vea8plG7NdygEVdJpagO9aiMQvkxxFcDl4y17hVgM=;
        b=CfFekbcw1nSpRY/0iUSM9D2W82vpd46Zg0t573d9QvxoM6L+J/HN1PJQgQqbr2Gaye
         cKW9NTAjg8Q8O4lhBbX/0sF/EUFeJdOFeTdwckxTmEAid5D8WdVhdXNpmLCxEjgJP8F+
         Kv8ks4hmXt4xTjNs50TTwY+i/hiuH+3aGLvd4bB3j+XLO+mi52Fy17s9hCfZz35ofcLw
         iXDaBebaQ1ZugecbKp5KbDeQgDM2mzJYriXKFp5uSAMd877kOQZfEaqbd0PfijeDUYVo
         yAhy8dTUufd+sNPTHh136m65KPexJoqUx36Qcg1WKUQcwtdY/TlVaVtIzGRTFKzTA+YQ
         GvhA==
X-Gm-Message-State: AOAM530ppnXgkC70KutvqM1vGbQb2dUSs3d2EhEvOebdaHpq4BzSeZNc
        akwwd7D+XhCLK20u0qMfM/jZHf38UdfgZNvn1Zkm7A13IDry/g==
X-Google-Smtp-Source: ABdhPJyJlqSq579IOa444NxezIZu364d2xx7ujWPNs4VT85tSXATFc06+6N4r0b0i61MGpILYb+/3O7BZrS2iFnxxVY=
X-Received: by 2002:a17:90a:7e8a:: with SMTP id j10mr8582758pjl.13.1642134697015;
 Thu, 13 Jan 2022 20:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20211124214418.GA1094@raspberrypi> <CAOoBcBWHi+UJENsfNzG2NMAjBj0RjsKSWNDaQ+++F-uL0ubAYQ@mail.gmail.com>
 <f227bd950c3b7c060b4b581f5604fe4d9103e942.camel@linux.ibm.com>
In-Reply-To: <f227bd950c3b7c060b4b581f5604fe4d9103e942.camel@linux.ibm.com>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Fri, 14 Jan 2022 13:31:25 +0900
Message-ID: <CADLLry5kph-7RUE0FYYR87625mvBCOYJR93JWTZ7KWKUS-8FKA@mail.gmail.com>
Subject: Re: [PATCH] ima: Fix trivial typos in the comments
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Austin Kim <austinkernel.kim@gmail.com>, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

2022=EB=85=84 1=EC=9B=94 14=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 10:51, =
Mimi Zohar <zohar@linux.ibm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Austin,
>
> On Wed, 2022-01-12 at 17:46 +0900, Austin Kim wrote:
>
> > >
> > > There are a few minor typos in the comments. Fix these.
> > >
> > > Signed-off-by: Austin Kim <austindh.kim@gmail.com>
>
> It would be really nice if checkpatch.pl would catch spelling mistakes
> before the patch was upstreamed.

Thanks for feedback.
Let me make sure to upstream patch after executing
'./scripts/checkpatch.pl --strict' command.

BR,
Austin Kim

>
> thanks,
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>
