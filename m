Return-Path: <linux-integrity+bounces-5376-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A26A6C5AD
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 23:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCE117CD03
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C113A230BEF;
	Fri, 21 Mar 2025 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HNrktze1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B21EE7DF
	for <linux-integrity@vger.kernel.org>; Fri, 21 Mar 2025 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595227; cv=none; b=PCiZNsq6Al5gNgZlBvT6tflOYlLZG4Lyw2yl4xvvmKBQdc3DcoHhi5dvUBUkkOoab0NblDdb/Yxl1VuGig3/QqFwHbq0Asy6oWeS8yjc5ZiE13bnW2fUtSR5U6JMixv/6q/T2Xh2AyyVTyWNbw+ErCHqyOv4lvAH6zr1RGK7nTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595227; c=relaxed/simple;
	bh=GBOEPaOJFDQiXRLYItd1K1GXT+xdrVAZm5t2iMoBUOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDrcPruHuRXfVGo1GYQhnLbLnheXrGxxDsG+rzoU6Nxlx9/6WUD8Utoo8mIAbZ2uq5pfIOl1ATQqU+W+DFpFKCApEqYKT0c9zfmMLbNFBL3WL8KTE2qyivswPC97tNJLh4mpa59Ni79Jbz2h4QNqRUdahEM2x3r8ayeTDVi20uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HNrktze1; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fed0620395so21859767b3.3
        for <linux-integrity@vger.kernel.org>; Fri, 21 Mar 2025 15:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742595225; x=1743200025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBOEPaOJFDQiXRLYItd1K1GXT+xdrVAZm5t2iMoBUOo=;
        b=HNrktze1ncxbb62iXNjE9zgqxrgrlWit3RYi2onSfojLBHRcUK3wxQy05QQEA0pQtq
         X25U9Fc+9qTEBSyZacRmlbtGQda/eDVmwI1G+4KrYSHViaUnRGagdGgmVz6J/HpazzoX
         yDBZ/1oN1U3lGLPZSVtPFDJeTDaJASbYt11FUZBiGmk1RICnqcjYGMmAoZqwI6kn/E9P
         btbd/4gxtq25hLTOXsCFqU8BWrkm/C9+CWgmn73JzM+o7fi3YmyAVid2gVkBR4v/3j5q
         YlBbalrWyyraw/RgiwayjoQT3qt/gypPKW2/7MyuY0QWX6uGLbEFtWvnCHXrB9uVNO4z
         fe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595225; x=1743200025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBOEPaOJFDQiXRLYItd1K1GXT+xdrVAZm5t2iMoBUOo=;
        b=NGWe6E5kkWMryLEmGuxhUZN7RvfZ6WO1ZCghoGdf6FK82UyKiUlmwJ1vokqNqjmMRf
         yzzCr7x+cwNy9UGEgnTaNXvTF1vxXqdipPUJYOwv3S5kOAAs+G10xIenqQfCWBzcgqVR
         ihpDRjwrFS9CVOSVl7ZskbC/UU/D5wPncbpr8fU0dvjzHDsrfHkvre2bX2c5QAJRP7Tj
         YiIlF5nyUh0ai1g40g35/flC4w6+u7viw2gEkPWE3etgrLKu4oJ+0xu25r36YndYZLVe
         /4iF/FjR8a0LSJqzyF2XKoLKu7p2shAhUhWU+Py9o6t7S6EzRuFY+TFhJqiXrRlIpyUu
         7KWA==
X-Forwarded-Encrypted: i=1; AJvYcCVRu5Cb0XZk8RmtISXJQF90iLVRbZa+HfHQ6vAOGqKe+GUlGk4AnkMpSaaEKyZQLndTFFBc0xIIEA2TLH9qOU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvjce6oqOQgT0j+AChpiRs/8/11EeRkiHY9igkyJaa+3j4sGh
	NFtqd22rKup7yjXQodubbrCfR6/PM8uHUUtRrWxcGB0F7zDHqCRwsStXYHUsvBW6024DjKF+bSY
	3VvrEtioXT3Tm+27xqaQy4/O0WAmsuTNAU4hz
X-Gm-Gg: ASbGncuLZoOc2LMHWW4zKg0B1AFJ1N7dA8YATI5jKY4ibmM267Ev8bShjaqXY7aimJL
	xvbU/GX4qVwL0Gy5IXgAViryiUfQUDyzAYYH71TG4EvOxmk48aEr7QNMtrEeq/o7xSPp0HwwurL
	qhbNRtrbZcFEB27OKktSnmG0HGxQ==
X-Google-Smtp-Source: AGHT+IHNPLUTnWnVVINienwbN23fI4lbcEBq04OEZSoIjUpzF2VR3DWEtJjTsjMmTP2DQeMvR1Q8d/Tp8Wyud6b0EzU=
X-Received: by 2002:a05:690c:9001:b0:6f9:8605:ec98 with SMTP id
 00721157ae682-700baccc9f8mr42056747b3.28.1742595224935; Fri, 21 Mar 2025
 15:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com> <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com> <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com> <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com> <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
 <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com> <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
 <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com> <1956e7f9d60.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <A3A29FB9-E015-4C87-B5F0-190A4C779CB3@oracle.com> <CAHC9VhQMN6cgWbxdAgBNffpCAo=ogGdm4qBGS_kKdDmiT8b3cw@mail.gmail.com>
 <B89ED288-1A01-41D2-8ECF-285669139553@oracle.com> <CAHC9VhQb55+SmwmrsVpyw5X2Ys0oo6gJ_dbDf64mS5c008230A@mail.gmail.com>
 <4F901DC6-51DC-47A1-8D2A-D84DCD9D0C2D@oracle.com>
In-Reply-To: <4F901DC6-51DC-47A1-8D2A-D84DCD9D0C2D@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Mar 2025 18:13:34 -0400
X-Gm-Features: AQ5f1JqPa2gcEPJOBuLUeSmEtx0Zy7l2iUmHgFLVu8IhxGEfOTtMxiXE9N6-wxo
Message-ID: <CAHC9VhT0y5AO0Yjy649PbsYnN+Xf3_pTJCegW1kPW7=GM9RypQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"ebiggers@kernel.org" <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 5:21=E2=80=AFPM Eric Snowberg <eric.snowberg@oracle=
.com> wrote:
> > On Mar 21, 2025, at 12:57=E2=80=AFPM, Paul Moore <paul@paul-moore.com> =
wrote:
> ...
> > , but I will note that I don't recall you offering to step
> > up and maintain Lockdown anywhere in this thread.
>
> I didn't realize that trying to contribute a new LSM and being willing to
> be the maintainer of it also involved stepping up to maintain lockdown.

It doesn't, but your criticism of how Lockdown is being handled
definitely falls a bit flat.

--=20
paul-moore.com

