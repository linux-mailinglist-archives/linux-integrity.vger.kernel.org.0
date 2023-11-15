Return-Path: <linux-integrity+bounces-53-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3649A7ED542
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Nov 2023 22:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917212810E7
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Nov 2023 21:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995C42E40E;
	Wed, 15 Nov 2023 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQU52lc1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A30043ACA;
	Wed, 15 Nov 2023 21:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E94AC433C8;
	Wed, 15 Nov 2023 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700082174;
	bh=amAyqsi96+KIo8jVI7yrm8bYp50p+LjkFfJin590EQY=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=tQU52lc1JSc3olebP0l3uSjB4xeMi0lcT0q5n8jHrSb7mBhlt7LyhqnzDZRmbLr2A
	 f6HlCOCcJgjEWCGnedxgfZ28jWHFDeUSuRXPLhTe7e0ud0Rz3QKwcl7KNh1Ntv+gcX
	 RoDL80kx6+r0xdOelwlHsxSOrPROCnyTKUvqNK6nmkMofnRRg7XmWQ5RjHRlCDPo+A
	 G6hfugcRuqKvKha5nF4OMeJkJth00I2dP1GodwfE0iD61qEB2oQxQxBPwMAfU3GGts
	 pAQrlkuP4RUR5ZhncqfaEkSKZw6ni5sR7r9J2tc8ygAcmTCELV/LrLanXDy6UGb3WG
	 tt276Q2ocE5AQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Nov 2023 23:02:48 +0200
Message-Id: <CWZOTY9J9VUU.39FYDBM2MZ153@kernel.org>
To: "Jerry Snitselaar" <jsnitsel@redhat.com>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>, "James
 Bottomley" <James.Bottomley@hansenpartnership.com>, "William Roberts"
 <bill.c.roberts@gmail.com>, "Stefan Berger" <stefanb@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Peter Huewe" <peterhuewe@gmx.de>, "James
 Bottomley" <jejb@linux.ibm.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Julien
 Gomes" <julien@arista.com>, "Mario Limonciello"
 <mario.limonciello@amd.com>, "open list" <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] tpm: Store TPM buffer length
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-3-jarkko@kernel.org>
 <lifu6orgfo57usei3szyfrmr6ofl37477gji5xh5bwkhftswxg@cjwwa5okjshi>
In-Reply-To: <lifu6orgfo57usei3szyfrmr6ofl37477gji5xh5bwkhftswxg@cjwwa5okjshi>

On Mon Nov 6, 2023 at 9:26 PM EET, Jerry Snitselaar wrote:
>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks.

BR, Jarkko

