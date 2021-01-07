Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018012ED3B5
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 16:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbhAGPqw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 10:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAGPqw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 10:46:52 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A5DC0612F4
        for <linux-integrity@vger.kernel.org>; Thu,  7 Jan 2021 07:46:11 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a12so15595384lfl.6
        for <linux-integrity@vger.kernel.org>; Thu, 07 Jan 2021 07:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxQ+JTyfhGK8yByYjmU4911PC71djTWrg1cCF9QZVsg=;
        b=lclI7uTEyvy+d0CXnZuSe2FmKiOAD0zb1vJMuyQ4W1RSx+PmI2RgIt0BNbkia0/rFa
         EY8mQBoMDa5IIL2iYDD/bMzoRCZe0gGI8ajbv7BWLiMLgB2hdh4FmFlolxc3ZjWP3mQi
         SRTs0xUpJnd5FU+04IrgUVZAH+duP29t1O5IU69hKk41zl85Js1oqWGiHZkQsdGNZil7
         Sgg5X+Rxj14u+iqU5ak3eSdpn/YNZD3ceX/IHCEU/IAmsmxZaU4eFGyeseWgnERgMxFR
         KR2mo16Ulikxmj9p4SSx9hyFlSLgRjH8w0M4JFxXJGnXCioI1P36T8sJm358xhlBrGUk
         ilNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxQ+JTyfhGK8yByYjmU4911PC71djTWrg1cCF9QZVsg=;
        b=p7e3/l85yHWGVqXgR2V2L1kenylbq0Md+v3Rz0T9euhQheN9LxlnvNSnwShsBKEs7G
         f1azZa56CMBEht8HvREpKKEsq7c8yJyQKwaDlreoWoMI/5N77fGuq+xvZlzOVymzlZuE
         Me4EWz078mC4hE24PgYOLmvhgRt/ZM1G0bugF4ayJeeF4Wy75NWJqn14byK8wvMPSnTC
         acXwDi8WTgSXwmKajfL8Nv0PCdS5thpZWfHjVtO4FL4c8sLdfuhBHpJtT1QHKZZJlb0K
         XLpDbuld/ocxsMtt8SfoJjFMtic+9qFaTatqlEZIcMApdECBsKOA8PtSU9OXeuTLyjPt
         vw1A==
X-Gm-Message-State: AOAM530FrMABTzqh69NjmAkLOgeJFDz1BNC/52xdPYdXWgZNMTLo3Rqs
        lIbfmyITHTJeT1MvTnZJmpfgB4H7SxSbcMVjI5DKRTznOwU=
X-Google-Smtp-Source: ABdhPJxJ2OY5l6Y/Fc+ZQQoF12tGyoTAqetFSXCmt6dv0hRdU80m60xP4v+JvXVJP2UrLnojw4Jaa6+d/gd8KWipolw=
X-Received: by 2002:a19:8b8b:: with SMTP id n133mr4515554lfd.278.1610034370458;
 Thu, 07 Jan 2021 07:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
In-Reply-To: <20210105195742.2629-1-raphgi@linux.microsoft.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 7 Jan 2021 17:45:59 +0200
Message-ID: <CAE=NcrY7oecVUtoGd2Jwzb6wi3i11zFPrYj3u84w9eCdOyTi4Q@mail.gmail.com>
Subject: Re: [RFC] Persist ima logs to disk
To:     Raphael Gianotti <raphgi@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        balajib@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 5, 2021 at 9:57 PM Raphael Gianotti
<raphgi@linux.microsoft.com> wrote:

> In a thread with Janne Karhunen[2], it was mentioned that another
> approach, using mm had been considered. Upon some investigation the
> approach used in this RFC still seemed adequate for solving this
> problem.

Curious to hear in more detail where did this land?

Not sure I remember this correctly anymore, but wouldn't it be
possible to have mmap'd tmpfile at address __heap of size __heap_sz
and have something this simple pulling memory from it?

uint8_t *get_static_buffer(size_t size)
{
        static size_t buf_index;
        uint8_t *bufp = NULL;

        size = ROUND_UP(size, sizeof(double));
        if ((buf_index + size) >= __heap_sz)
                return NULL;

        bufp = (uint8_t *)__heap + buf_index;
        buf_index += size;
        *bufp = 0;

        return bufp;
}

Then just replace every related measurement list allocation with this
get_static_buffer and that would be pretty much all there is to it?

The mm code should automatically push those pages out when it needs
memory. It will also read those pages back in when someone scans
through the measurement list creating a nicely formatted one. I think.


--
Janne
