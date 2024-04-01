Return-Path: <linux-integrity+bounces-1950-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA09893C1E
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Apr 2024 16:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADF4B20EC7
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Apr 2024 14:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76F405FB;
	Mon,  1 Apr 2024 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Zly0mL8c";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Zly0mL8c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F33FB87;
	Mon,  1 Apr 2024 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981178; cv=none; b=XVK4o8u+RaLJK+1Gi5yo5Ikz+V5qZJS3a2uKtQxQBJ+EnW6gUPIBGSu6yr9JwkkKhGhZMPWyIaAoh6ptaLADwWOvRFihzJUwYZNEdo8g54oOZYDkaxUC72ApNqCNJATIFCf7FTpFtuQDfDuXAGpwcw9DWqeuhOAtGP+/NnqKcu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981178; c=relaxed/simple;
	bh=3Avj0CGEJSSoDdYPAtfsxnyPNI5rx9xDHqYzLCWTzZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=djxX2fZcTbb1wx+hzKS4kOEh7wvYaNHnNkTC+q4qRTMOlUlfvNxazDnZkVlqOCq+N8GlmkF18Jn04tFdC7a+YIHBqZYhC8F7z0NVFfd5/7TT3ePczRNPS5gY482H49CpSVO2o59LWfCKwkPU2lmIzyBAtT+BN8FKWk2WoDPyDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Zly0mL8c; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Zly0mL8c; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711981175;
	bh=3Avj0CGEJSSoDdYPAtfsxnyPNI5rx9xDHqYzLCWTzZc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Zly0mL8cvWd6kA5fGvah3aMBiqumOEC0QMb878Edg+HmiYDbQo52KBQY2OfGMqWQA
	 1FbKA0ffLWd0Xvuwn0tOTYNHYk8WL6ohVjv8JsUM9Zyzmze291RLtLpEH1z+GG1hmP
	 AV4GYl5M9OR4Lxv37i8OcVlMkpl8RWucP6a69B2Q=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6FA1312872F9;
	Mon,  1 Apr 2024 10:19:35 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Xpl6paheXjCt; Mon,  1 Apr 2024 10:19:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711981175;
	bh=3Avj0CGEJSSoDdYPAtfsxnyPNI5rx9xDHqYzLCWTzZc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Zly0mL8cvWd6kA5fGvah3aMBiqumOEC0QMb878Edg+HmiYDbQo52KBQY2OfGMqWQA
	 1FbKA0ffLWd0Xvuwn0tOTYNHYk8WL6ohVjv8JsUM9Zyzmze291RLtLpEH1z+GG1hmP
	 AV4GYl5M9OR4Lxv37i8OcVlMkpl8RWucP6a69B2Q=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A5EF81286BFE;
	Mon,  1 Apr 2024 10:19:34 -0400 (EDT)
Message-ID: <ad409aa8834c37d7bfe2666e03520dd777afd288.camel@HansenPartnership.com>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: =?ISO-8859-1?Q?Gabr=EDel_Arth=FAr_?= =?ISO-8859-1?Q?P=E9tursson?=
	 <gabriel@system.is>, linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, Ard
	Biesheuvel <ardb@kernel.org>
Date: Mon, 01 Apr 2024 10:19:33 -0400
In-Reply-To: <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
	 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
	 <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-03-30 at 18:48 +0000, Gabríel Arthúr Pétursson wrote:
> On Tue, 2024-02-13 at 12:13 -0500, James Bottomley wrote:
> > +       /* unique: key specific; for ECC it is two points */
> > +       tpm_buf_append_u16(&template, 0);
> > +       tpm_buf_append_u16(&template, 0);
> 
> Shouldn't the points be 32 bytes each in size, filled with zeros?
> 
> The TCP TPM 2.0 Provisioning Guidance defines the SRK Template as a
> diff on top of Template L-2 (for ECC keys) as defined in the EK
> Credential Profile 2.0 document.
> 
> Template L-2 calls for the X and Y points to be of 32 bytes each,
> filled with zeros. The Provisioning Guidance does not call for zero-
> sized points.
> 
> For example, let's create an ECC Endorsement Key using the standard
> template then print its name:
> 
>    tpm2_createek -G ecc -c /dev/null -u ./ek.pub
>    tpm2_loadexternal -c n -u ./ek.pub
> 
> Equivalently using tpm2_createprimary:
> 
>    perl -e 'print "\0"x64' | tpm2_createprimary -C e -o ./ek.pub -G
> ecc -a
> 'fixedtpm|fixedparent|sensitivedataorigin|adminwithpolicy|restricted|
> decrypt' -L
> 837197674484b3f81a90cc8d46a5d724fd52d76e06520b64f2a1da1b331469aa -u -
>    tpm2_loadexternal -c n -u ./ek.pub
> 
> You'll find that the key's public modulus matches that of the EK
> Certificate imprinted by the manufacturer, indicating we got the
> template correct.
> 
> To generate a standard SRK key, the TCG TPM2 Provisioning Guidance
> states we should:
> 
>         1. set userWithAuth,
>         2. clear adminWithPolicy
>         3. set noDA, and
>         4. clear the authorization policy.
> 
> There's no mention of alterations to the unique field.
> 
> Let's also create the key in the null hierarchy:
> 
>    perl -e 'print "\0"x64' | tpm2_createprimary -C n -o ./null.pub -G
> ecc -a
> 'fixedtpm|fixedparent|sensitivedataorigin|userwithauth|noda|restricte
> d|decrypt' -u -
>    tpm2_loadexternal -c n -u ./null.pub
> 
> The name does not match the kernel's name for the null key.

So this seems to be a fairly global problem.  If you look at
openssl_tpm2_engine, openconnect and gnutls, they all formulate the ECC
primary template this way (zero size points).  They all look to have
inherited it from the IBM TSS:

https://github.com/kgoldman/ibmtss/blob/master/utils/objecttemplates.c#L272-L275

Ironically, even the Intel TSS based openssl engine and the provider
seem to define it this way as well, and they definitely didn't get it
from the IBM TSS:

https://github.com/tpm2-software/tpm2-tss-engine/blob/master/src/tpm2-tss-engine-common.h#L149-L152

The problem is if we change it now, it would break all the current keys
with primary handles (which is pretty much all of them thanks to almost
no-one following the provisioning guidance about persistent handles).

So I'm not really sure how to solve this.  At the moment the kernel
doesn't use permanent handles for keys, but it should and it should
follow what all of the industry is doing for interoperability (i.e.
zero size points), which means the NULL primary should also follow it.

James


