Return-Path: <linux-integrity+bounces-3924-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775709B3082
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 13:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01EC4B22009
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 12:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261211D95AA;
	Mon, 28 Oct 2024 12:39:34 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3494C83;
	Mon, 28 Oct 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119174; cv=none; b=Uy67dTjDogocR6XZ0p6bwKIE/C1dVim4mWnU+qr4VhILv+NeS5uGJKDx8YKFkC2KodbIbYqZQJMsn6STixsS7N0tDS26/FE0lXjyv7WMaIlj+VGy+rcLelPna32Ayzi7BBMZJdXB6qTJSKboRs/7+Zfz4Ni3Xz29lt5wxDyKn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119174; c=relaxed/simple;
	bh=f/TexvBF0UCUEoSPWKmBASOK80VhssDA3j4/J1bQ46Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhS93vX2ink9vZ60RFY3RG84eS71wrM5TSm40feHgrsUR+dfq//zfOg9y29+P9Qf3wNWfLsnivmaoSnWXyASG28S0Dsw4EZFMVdDddaxK49T9rmYpJyyp4uiEycUzaZI86OEAT/QZl2eDwuLy+vmDOCCHkXyC7d8MyxC9gnMC9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9E95561BF4882;
	Mon, 28 Oct 2024 13:38:17 +0100 (CET)
Message-ID: <abc37c7f-b069-4272-956d-77e099cadf11@molgen.mpg.de>
Date: Mon, 28 Oct 2024 13:38:17 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] tpm: Rollback tpm2_load_null()
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
 Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Stefan Berger <stefanb@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, stable@vger.kernel.org
References: <20241028055007.1708971-1-jarkko@kernel.org>
 <20241028055007.1708971-3-jarkko@kernel.org>
 <88bfa0f8-4900-4c56-bd23-14d3b3c7de85@molgen.mpg.de>
 <D57FFOHZQDUV.QA3SZQSP63Q2@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <D57FFOHZQDUV.QA3SZQSP63Q2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jarkko,


Am 28.10.24 um 13:10 schrieb Jarkko Sakkinen:
> On Mon Oct 28, 2024 at 8:13 AM EET, Paul Menzel wrote:

>> Am 28.10.24 um 06:50 schrieb Jarkko Sakkinen:
>>> Do not continue on tpm2_create_primary() failure in tpm2_load_null().
>>
>> Could you please elaborate, why this is done, that means the motivation
>> for your change?
> 
> Which part of "not properly handling a return value" I should explain?

Sorry, where is your quote from?

Anyway, maybe explaining why a successful call to tpm2_create_primary() 
is needed to continue would at least help me.


Kind regards,

Paul

