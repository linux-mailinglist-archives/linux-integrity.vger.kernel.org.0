Return-Path: <linux-integrity+bounces-3699-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA498549E
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 09:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FBD7B213FF
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374FE156F28;
	Wed, 25 Sep 2024 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L09mQInY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E43154C19;
	Wed, 25 Sep 2024 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250788; cv=none; b=rPOgEV1DsrnywXZJYBLxEsYpy81U2LB2B/xZsCF+aJr2p9rcMRkMbuikSktcwWa+JlIgYGDGvZIcj4LOIABTYai38KjhDKyocgjwn/qAbnRLWS44BA/kHsEyY+yw11BraRUuCX3O8tHIxIcdJg8c3/juRu7vwlLoSjcL1xlJa0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250788; c=relaxed/simple;
	bh=JFD+/TLICslIFiwVPjoesgFsuWrdwIUahgsyCeOj96U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YrahciB5Jy6knaudVu4TzS2+j8SdlzYPGztpWtJ4APsrMCDa0eAw4SnihFtmeKPcKMUJ9B6P3LufHuY0Ww44tTHvDZKVhC9s4suYLwN/PqZtgNcF5G+jjlFkZ/ylZyBDhRin9qjeXlDhUxeJEUcHAddE68f3lfXJAb8EkCMfnug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L09mQInY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AACBC4CEC3;
	Wed, 25 Sep 2024 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727250787;
	bh=JFD+/TLICslIFiwVPjoesgFsuWrdwIUahgsyCeOj96U=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=L09mQInYz84uGJZbZpBXxi9BygP+ozfZGhGlnbSuydVvehTh6L9NvfGD2UydxKfhL
	 MEyFDvEZdwW4ZNQUIc929XNtKRRPo0xzQGqQfAdNbI0NlvNW0B+X7zGN5kmW5hSDC4
	 yis/qnvflml27pBWUodCn0jc/c3NZc4+B7M6qtxG7CoGXSGnHCKi1DpAfnYkdzPPx5
	 KL9qWYusc/Uc/H1A6o9JHV+Xl9AeQGGawy6VOADgfxrhLnSrWBmi1UQ110R3BmogeN
	 3ObjPdwJeCowTRjRUMoTqW0I0y3MBKixy3FBcg7ziotb0kxRNO+LnRJ1Uf2+TOnffk
	 HW61NjouL8dOQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Sep 2024 10:53:03 +0300
Message-Id: <D4F7AVX5A3KI.235GJ3NRMGWV@kernel.org>
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
 <D4F75ZA3WH4X.2LTKNXM4X60KY@kernel.org>
In-Reply-To: <D4F75ZA3WH4X.2LTKNXM4X60KY@kernel.org>

On Wed Sep 25, 2024 at 10:46 AM EEST, Jarkko Sakkinen wrote:
> On Wed Sep 25, 2024 at 10:42 AM EEST, Jarkko Sakkinen wrote:
> > Fair enough. I can buy this.
> >
> > I'll phrase it that (since it was mentioned in the bugzilla comment)
> > in the bug in question the root is in PCR extend but since in my own
> > tests I got overhead from trusted keys I also mention that it overally
> > affects also that and tpm2_get_random().
>
> I do not want to take null key flushing away although I got the
> reasoning given the small amount of time is saved (maybe 25-50 ms
> in my QEMU setup if I recall correctly) but it would make sense to
> squash it auth session patch.
>
> I'll also check 1/2 and 2/2 if I'm doing too much in them. Not
> adding any tags to v6 and it really makes sense to develop=20
> benchmarks and not rush with the new version now that I got
> also your feedback, since it is past rc1 timeline.
>
> Good target rcX would be around rc3.

I have to admit this: I had blind spot on that PCR extend comment
because I did not get hits on that when testing this so it definitely
needs to be documented. I spotted it only yesterday.

BR, Jarkko

