Return-Path: <linux-integrity+bounces-1481-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA338681E7
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 21:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE728DF76
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 20:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F06812F588;
	Mon, 26 Feb 2024 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="Qz2JysFL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B81E878
	for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979261; cv=none; b=IL5CER17JJ7Ye3hI31A8uk8jn8AwEIy73XPGItBJsex+PKmBPS4snpXB2mEM/4LH19hMlHuzfc1qRiPhygjFWfsqVrafcLJ1+BORhPEJ0iBaqsFg/XqdIUuN06nGN8BxUyxOJcZT9bDua/mOR4hELeHK+DPSMg5HROyXVx0DAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979261; c=relaxed/simple;
	bh=1fTb/Qk2z8YENO2bqKrTjbwY2HcLexTEgEmV7qIUSHY=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=HC7Cqsm5UxhaU7yFbiEMnLgcTB2fGU8bJxcvJwLN5oJx3hUNMjgdmZVVdojnkCS1crTEn+c4n/L08GKiD2nLliavnVMoVwy2011Xawb0rALKeJdoEa/jdrM+r31ne9ePL/CqD7Gi8Xqq/oSNPriTkonrQjhhs2GhHaY1CUCFprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=Qz2JysFL; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7810827e54eso281520285a.2
        for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 12:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1708979258; x=1709584058; darn=vger.kernel.org;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fTb/Qk2z8YENO2bqKrTjbwY2HcLexTEgEmV7qIUSHY=;
        b=Qz2JysFLMC/0LIJUfUxgLGeesc9ljIlL5GpfDZLJidfRmN8i8AiAGVuC71iwd7ee0i
         hhw/qMUOB2rr319m4J9HZmtdwZYxzZoCVGZgwb9I6TEOsLN8cXGd/ke+yovhqkDyLHJJ
         PCF2ExUrYMhuo9Yt5lGNRzsjVz40WHZgCsPZDlMKLLwOrTHRu8NAYlgI1bVv5IzpXHrn
         q8QR3kE6L1GKLZ+Z7wB1NZTnsGq0GPQRyObZTjIDs7sRIqqMRWivTg51E5Lel05OcZR7
         H1HnkNQcuwbNaJgy/xE9vGh61hlc/cxkExr+fD5hDt4CFEZGirNEUqpqcVGEo6GIrcsa
         PJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708979258; x=1709584058;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fTb/Qk2z8YENO2bqKrTjbwY2HcLexTEgEmV7qIUSHY=;
        b=phHXmDO7VhLNIlXyxEPr6vML91fkT0Qb4Li6jfiyBMbkw7GT8pcZuZ6r8VlANYwDjv
         90z4AinqaqAZuAfSKrGGOMRJinSXmQu5RgZ6dmEgek589opYL1AwhqStBOTxEiw9oyuV
         fyi8JF6/6uSsJ6mvchZGNziBFNldNwS41bW2ZYt1PSdDGCo7LTY0XbbsqzXNproWnMuj
         /av3XgSpWMZ6mzpnTc3/Pd7uLu+W4sInwOTKp3fSuxh2ICRuJp6apba2UUK/JKDPdTbO
         k4XWQ1vkvciHYHwvI7IV+0Dnu5M63PAL7USomObO+Xz3jCNgo4J34N3tzHWd+3NTM3Pj
         dQGA==
X-Gm-Message-State: AOJu0YylUeYndkS9XwADjNlvb0iddsH5uTuWF5As5dEs9d+y/1txQ3Oy
	IWEbBz/FHd7OcQSanipDLTG9tyuIhFR4GYogqmuLMZWP2oyjwa3wvTrhpmpZSLIOalohUV6CPzZ
	jE2LruQ==
X-Google-Smtp-Source: AGHT+IErVFeQ88JyBcaFUM9ogoWlaWjbX0plDndE19fRWOL+2wXBDvv6y8rH9sYqWy1POE3zeXwqMQ==
X-Received: by 2002:a05:620a:1213:b0:787:a853:607e with SMTP id u19-20020a05620a121300b00787a853607emr178163qkj.58.1708979257999;
        Mon, 26 Feb 2024 12:27:37 -0800 (PST)
Received: from smtpclient.apple ([2601:246:5b82:3b50:5b8:625c:fa00:d48a])
        by smtp.gmail.com with ESMTPSA id w14-20020a05620a094e00b007872ade6cf1sm2832968qkw.71.2024.02.26.12.27.37
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2024 12:27:37 -0800 (PST)
From: Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to LGPL-2.0-or-later
 and GPL-2.0-or-later
Date: Mon, 26 Feb 2024 14:27:36 -0600
References: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
To: linux-integrity@vger.kernel.org
In-Reply-To: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
Message-Id: <704C3BD3-5B33-46A6-9CEE-3D7DEAF9976E@u.northwestern.edu>
X-Mailer: Apple Mail (2.3696.120.41.1.1)


> On Feb 21, 2024, at 2:11 AM, Dmitry Kasatkin =
<dmitry.kasatkin@gmail.com> wrote:
>=20
> Currently libimaevm provided by this project is used by the tool =
evmctl,
> which is also provided by this project.
>=20
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
>=20
> To address this issue, change the project license to GPL-2.0-or-later
> and libimaevm to LGPL 2.0 or later.
>=20
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>

Acked-by: Tergel Myanganbayar =
<tergelmyanganbayar2024@u.northwestern.edu>


