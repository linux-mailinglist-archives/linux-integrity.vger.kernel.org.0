Return-Path: <linux-integrity+bounces-3697-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3490D985472
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 09:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657C41C2367B
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 07:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80E415853E;
	Wed, 25 Sep 2024 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVE9lrlZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4115852F;
	Wed, 25 Sep 2024 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250403; cv=none; b=jqphBibUP46M71CnvFPOuMQPl6V9wXwTZMUvg3aZgzOTc/0rMbAIQ7xhYa4d1Fwplai9JhmD4VQtEo84ACsTEJIFuOmipgmxliZf7Fz8I11k448u8wR2lpHZXoAsnlxIvH5uXQjJlfEW4xmyMeAl509XhmaWl78PN73EJwzdNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250403; c=relaxed/simple;
	bh=gL9fWAQbBAqwAotYYcbC3CfevPSo7imSq39pgy8VqDI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uGwhGACWEdXIt5tPeaiM3DhnOkXzmZ9lAnEO8Z5kpj4zau+hQOxSTZhQ14zRh4FiGEk/JK5KwAZFXZIFR/wFZgM/ekseBcc68hpnLw0pxdfU/BvzGnMUOu8b1jP4eAj3M4T21L+dyOLGg2mHw4pDHAeF8W6kRTalYKrRGkTtKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVE9lrlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C8BC4CEC6;
	Wed, 25 Sep 2024 07:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727250403;
	bh=gL9fWAQbBAqwAotYYcbC3CfevPSo7imSq39pgy8VqDI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=lVE9lrlZ1wM2F1DxuN2JDERdW6f9Yd2VkuwnUejsx9LhwJm00nD8q/0yUSotAWfNo
	 YZrIDxOkkfCACaOTSexine33/+a3dkTloxe0+ZAwzeqwTLh8/oOpYG8niizcQ3EMbc
	 hqItl8+dig61uSvXUGXtEO4tFw30kf2R+p/Nvkukjj3idcg2lZGdkVbQhLp6xZQHjL
	 OkEg9ytMcV5H6qiE5ImhscNRpmUZi3w2gZao8affFyvsCiZeAKU26jVoJJlFiSRMI8
	 xJKypo4EC9PcX4S6oZvTYdiLcZh5BeIQQ98TdcxibAADMy1w46ZLNtKPSFsxFSUo1v
	 PhdnOtMuUoaPQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Sep 2024 10:46:39 +0300
Message-Id: <D4F75ZA3WH4X.2LTKNXM4X60KY@kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>,
 <stable@vger.kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] tpm: flush the auth session only when /dev/tpm0
 is open
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <20240921120811.1264985-6-jarkko@kernel.org>
 <00cf0bdb3ebfaec7c4607c8c09e55f2e538402f1.camel@HansenPartnership.com>
 <D4EPQPFA8RGN.2PO6UNTDFI6IT@kernel.org>
 <f9e2072909d462af72a9f3833b2d76e50894e70a.camel@HansenPartnership.com>
 <D4EU5PQLA7BO.2J5MI195F8CIF@kernel.org>
 <2b4c10ca905070158a4bc2fb78d5d5b0f32950ad.camel@HansenPartnership.com>
 <D4F72OC53B3R.TJ4FDFPRDC8V@kernel.org>
In-Reply-To: <D4F72OC53B3R.TJ4FDFPRDC8V@kernel.org>

On Wed Sep 25, 2024 at 10:42 AM EEST, Jarkko Sakkinen wrote:
> Fair enough. I can buy this.
>
> I'll phrase it that (since it was mentioned in the bugzilla comment)
> in the bug in question the root is in PCR extend but since in my own
> tests I got overhead from trusted keys I also mention that it overally
> affects also that and tpm2_get_random().

I do not want to take null key flushing away although I got the
reasoning given the small amount of time is saved (maybe 25-50 ms
in my QEMU setup if I recall correctly) but it would make sense to
squash it auth session patch.

I'll also check 1/2 and 2/2 if I'm doing too much in them. Not
adding any tags to v6 and it really makes sense to develop=20
benchmarks and not rush with the new version now that I got
also your feedback, since it is past rc1 timeline.

Good target rcX would be around rc3.

BR, Jarkko

