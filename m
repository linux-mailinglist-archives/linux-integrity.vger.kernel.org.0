Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55893EBD14
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 22:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhHMULW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbhHMULW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 16:11:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1063FC061756;
        Fri, 13 Aug 2021 13:10:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d4so21887684lfk.9;
        Fri, 13 Aug 2021 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pdc/PrD8jzWT9fWT63pVy8TYQhI7f7V+K4BKhr3yyc0=;
        b=UxtT53tped0sAyIntZUy+vPnuhQuMa9klZOb3CRIItqp5gAaVyyHT27hVekmFMr3g3
         WmcrTCdgD89Wyg1bqb0OD5GUGnOCEJE4dSX6RErfefCvO6aT4UYh6zr0SHlPNvYp3y+i
         ehtY5nR8vssE90Izzgde1PfEsdSJEGq4UbZfB9NsCM2xuWI5hs3qOMEZFYrRYmq9eQct
         8v9sJk3mQOYCsmWgP2T/WreV0N1gOMIXYHXIQCj9GW4H0tY78b3PnnDyhZ0j2N1n8DG/
         UFduDBMTxlTNHc1XTeeJt4mLFiaTY+5S356nLWWO8XyiFtTmDrLw1jTHVJCzPAn7BV6t
         o5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pdc/PrD8jzWT9fWT63pVy8TYQhI7f7V+K4BKhr3yyc0=;
        b=Esgr/kmTh9D6W3fzUn4Ngb2zGJBmLTTSj40HSmZDLBLeBX/WezPqpoqkJ86dwSy4uW
         zjH2qEou5nDwiGosDarRrTb90gv4AQytss6EzRJ2+B6/tnHB2Ds7oVQ4YV0TMOvvbBuE
         Q1hsZOM5PLyPcYAz+UgXUGJ0lNu+7IRi+r6wflOwwXSet6AFqemsiDUwy11yxEq7aGdQ
         BiDZ3t0GOsdA7afjz3rRMGrwR5NjfgodWsOvJkD7da+mq/PgjT4aWkR4YeDpPjlL7N5R
         DBjaPwI7ZuopOkmkVxtaYe8+mVJu/jI2zRSHfYuZJFJLvcqnMj/QAdBRkidzLRfz7wrF
         mkCg==
X-Gm-Message-State: AOAM532FMun8B6nPfrNtpCwZVTiLHngJBuJqvsw1sjJ4xjSHJqwQGsZJ
        3S5s7p7HKA/7gUZrouhlIsHVWgBDzPWKk340Rrk=
X-Google-Smtp-Source: ABdhPJxxYkAbg1CqOzDm05Pi8G1A0P5u5YMYuMnFCZghPN3iuUa2XCGYBO8AvIhcLTQYtZdU5n/Rt2T+QT5iELHSULw=
X-Received: by 2002:a05:6512:1501:: with SMTP id bq1mr2819888lfb.36.1628885453446;
 Fri, 13 Aug 2021 13:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru> <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
In-Reply-To: <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
From:   Igor Zhbanov <izh1979@gmail.com>
Date:   Fri, 13 Aug 2021 23:10:47 +0300
Message-ID: <CAEUiM9NnimMa2V2xN80kMox9gyOtUqhtPV1OPK3Ea83+JkxPpQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
To:     THOBY Simon <Simon.THOBY@viveris.fr>
Cc:     Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

=D1=81=D1=80, 28 =D0=B8=D1=8E=D0=BB. 2021 =D0=B3. =D0=B2 13:19, THOBY Simon=
 <Simon.THOBY@viveris.fr>:
> The kernel style guide mandates that all variables are only defined at th=
e beggining of the
> function, and not at the beggining of any block like C89.

I've checked the kernel coding style and couldn't find anything about
variables definition
place. Could you, please, point me to the requirement?

Scoping variables declaration makes the code better and more secure.
Besides, I've checked the kernel sources and see many examples of that.

Thank you.
