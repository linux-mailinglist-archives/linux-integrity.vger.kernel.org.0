Return-Path: <linux-integrity+bounces-7364-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD797BB8B47
	for <lists+linux-integrity@lfdr.de>; Sat, 04 Oct 2025 10:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 820EA4E1C6D
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Oct 2025 08:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B370A18FDAF;
	Sat,  4 Oct 2025 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="YiFHVhgE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3EF322A
	for <linux-integrity@vger.kernel.org>; Sat,  4 Oct 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759566944; cv=none; b=mzqXf1cqpZIxEREheTJcORsNNvMyw2+kluNmk+tndzEwlPWWm53sOZ2pLuR9yLt9qv5M40i3PldBwPo/byAeWnDOevPVQVr3oOCzmi9k/oo3At/03uaqHZDdh6kreiH7I+N2W7Zm1itHEXA60f6jsYf+ITfn3T+iHEKna+zHMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759566944; c=relaxed/simple;
	bh=t0S21gYyo7eRaP9+88S3WoJCHO6nkljYG7DExrHhjmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PikIH6+gzVh3Kp3hQYgFBibgdwr50OvRs4tuUEOqivLbrOSfJ3xWkAg8ChycvxJg6yXnb4/ZVHO9qw7jTvyeFAwlXSrVw9LwGGpD7R3RXMxArsBDjF4g5JSueVEefsMJSQ6wuOhPJEAvmUZx1GfRIUitLxrAX/B2+kl0YNGk3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=YiFHVhgE; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id BF18B240101
	for <linux-integrity@vger.kernel.org>; Sat,  4 Oct 2025 10:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1759566940; bh=ojT6o3fqx9yoN4VZsVYxlr2GEiqB3WxDl+QSQ8TADVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=YiFHVhgExP2vgmTMbCnSIeR1RJjnUVq/1dAhZJy1np5ty1D1Z+Gdl8mQsyJ9EAj+A
	 UW9lePV0HZpFCf5D9sl31AnH9R4CLbVmX+A+ps/6J31rd7SLuwESfo4HFoSa4jYsWb
	 ZN4LTd694y/LFCi0r2UU7VTnMfh6FGNdkHtMEUaAeQx41RBOxQmkksJHikJ1Pg2rPB
	 zjGUp49GdOMO98G2HhtiR5+7cS8WU9SpoV6NOLSUt5F2R3sqjPQzLB7/3kOrYqqE3P
	 YwFYo3k7B2xfb7nNlAHGmU/sT5uoW/ns2gr7mgHHEYW/NKWzDKUE0v4aj1lLBj5oDa
	 d8FX6o5LnLikQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cdzPl6YGHz6tm8;
	Sat,  4 Oct 2025 10:35:39 +0200 (CEST)
Message-ID: <8ce2f56c-4fea-47e2-a0e2-9b24b66874ff@posteo.de>
Date: Sat, 04 Oct 2025 08:35:40 +0000
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tpm: infineon: add bounds check in tpm_inf_recv
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251003092544.12118-1-shahriyar@posteo.de>
 <c0a4d2bb-be78-4aac-b66b-c1eb766e7efd@molgen.mpg.de>
Content-Language: en-US
From: Shahriyar <shahriyar@posteo.de>
In-Reply-To: <c0a4d2bb-be78-4aac-b66b-c1eb766e7efd@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Paul,

> 
> Is it possible to enforce this situation to ensure your patch works?
> 

Triggering the issue requires interposing the hardware or a MCU to 
emulate the TPM and send malformed TPM replies, I might be able to test 
this using Qemu, but that takes some time.

For the rest of your suggestions, I'll send another patch.

BR,
/shj

