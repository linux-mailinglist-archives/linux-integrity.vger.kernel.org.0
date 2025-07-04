Return-Path: <linux-integrity+bounces-6614-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ED1AF85CC
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 04:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B26565BF6
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 02:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E424D1DDC0B;
	Fri,  4 Jul 2025 02:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzbvUBJV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5E1DCB09;
	Fri,  4 Jul 2025 02:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751597814; cv=none; b=S5wTE+hoCBLjjGLHbrfw1l7NsWSHHbCXwymydzJzz6YBJ9ngtO6PAzXZSPi7VJPiBuy59fn5pWXFWj24oo9n5O8ni7+9c3nUpg9P6/pyTRGISucK3rIThbutV7K4gnSpos91CLHOLvc+u69MoP04CG1JZOYrpHst3unfGTxzbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751597814; c=relaxed/simple;
	bh=dpKVhbg7scykD3su9SjXQjOIqalbcvI5GMk6pb9f330=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhgLqZ3+lCquK1moEXB3NdQrjOP7Ck3KzOcZhOSnABFIYsIKRl1YOgDJ5J2KNnSfAk8HpAyBKcOG83DWTqcbXz1EFP1FPo4Z5WRVproSD+DhpQxzeIxG/jmT+NZGs9rJPXpsxbmLbLOWlCXtkITD0uUqkGFtnClFJWQZTvJWEgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzbvUBJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B0BC4CEF0;
	Fri,  4 Jul 2025 02:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751597814;
	bh=dpKVhbg7scykD3su9SjXQjOIqalbcvI5GMk6pb9f330=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzbvUBJVeecszUyXLvImzILJGBClLv+O5DjY1gGAgL+hzspJC9pfCzoAYJXVjEwVe
	 rk/yN6nvuaI6jcQrKTDvqJv6QYJZySe+YZm+9H/GOaurArFaOQC0jFoJSri6ejeSF/
	 sfF9mOQGBbTOx5aQC93NyXABMRjmwv68EXpQqdbSQw9pQi3dtPVvGmTYFx+k8d5qbe
	 mVWY0Kbib4Z4KaykDVElREWOhuWTYm51s6na7rDax5TX3AVuSSaIY8woqOjtZq9W8h
	 UmO2eNvpJ7pZrATUd8o0pWqRaeujROLjIZSC9qzaFjPa6NcA3r+3LNqJUR1WX6xdar
	 z+YgYOIrB4q4Q==
Date: Fri, 4 Jul 2025 05:56:50 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] tpm_crb_ffa:Introduce memzero macro to replace
 memset
Message-ID: <aGdC8gyO00AB_aPr@kernel.org>
References: <20250626184521.1079507-1-prachotan.bathi@arm.com>
 <20250626184521.1079507-3-prachotan.bathi@arm.com>
 <aGWvtzhs5ksKgaYo@kernel.org>
 <151a612b-198a-4f7e-94e7-10426831ab94@arm.com>
 <aGdAMg43nHPwgeKn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGdAMg43nHPwgeKn@kernel.org>

On Fri, Jul 04, 2025 at 05:45:11AM +0300, Jarkko Sakkinen wrote:
> On Wed, Jul 02, 2025 at 10:58:56PM -0500, Prachotan Bathi wrote:
> > On 7/2/25 5:16 PM, Jarkko Sakkinen wrote:
> > 
> > > On Thu, Jun 26, 2025 at 01:45:20PM -0500, Prachotan Bathi wrote:
> > > > Add a memzero macro to simplify and standardize zeroing
> > > > FF-A data args, replacing direct uses of memset for
> > > > improved readability and maintainability.
> > > > 
> > > > Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
> > > > ---
> > > >   drivers/char/tpm/tpm_crb_ffa.c | 6 ++++--
> > > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> > > > index 089d1e54bb46..397cc3b0a478 100644
> > > > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > > > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > > > @@ -12,6 +12,8 @@
> > > >   #include <linux/arm_ffa.h>
> > > >   #include "tpm_crb_ffa.h"
> > > > +#define memzero(s, n) memset((s), 0, (n))
> > > > +
> > > >   /* TPM service function status codes */
> > > >   #define CRB_FFA_OK			0x05000001
> > > >   #define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
> > > > @@ -192,7 +194,7 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
> > > >   	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
> > > >   	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> > > > -		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
> > > > +		memzero(&tpm_crb_ffa->direct_msg_data2,
> > > >   		       sizeof(struct ffa_send_direct_data2));
> > > >   		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
> > > > @@ -205,7 +207,7 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
> > > >   		if (!ret)
> > > >   			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
> > > >   	} else {
> > > > -		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
> > > > +		memzero(&tpm_crb_ffa->direct_msg_data,
> > > >   		       sizeof(struct ffa_send_direct_data));
> > > >   		tpm_crb_ffa->direct_msg_data.data1 = func_id;
> > > > -- 
> > > > 2.43.0
> > > > 
> > > It adds a ross-reference to the source code, meaning that you have to
> > > jump back and forth in the source code just to see that there is a
> > > function that wraps up a single memset() call.
> > > 
> > > How does that map to "readability"?
> > > 
> > > BR, Jarkko
> > 
> > Hi Jarkko
> > 
> > I've implemented this change post your feedback on v4 of the initial patch
> > series, maybe this should've been a question at that point, but what was the
> > reasoning for recommending that I use memzero instead? I'll use the same
> > reasoning to rephrase the commit message.
> 
> OK I found what you were referring to:
> 
> https://lore.kernel.org/linux-integrity/aFF-WNSolTdV9PZG@kernel.org/
> 
> Well, that was some truly misguided advice from my side so all the shame
> here is on me :-) There's no global memzero() and neither explicit
> version makes much sense here. Sorry about that.
> 
> I gave it now (actual) thought, and here's what I'd propose:
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 96746d5b03e3..e769f6143a7c 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -203,26 +203,20 @@ static int __tpm_crb_ffa_try_send_receive(unsigned long func_id,
>  	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
>  
>  	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> -		memzero(&tpm_crb_ffa->direct_msg_data2,
> -		       sizeof(struct ffa_send_direct_data2));
> -
> -		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
> -		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
> -		tpm_crb_ffa->direct_msg_data2.data[2] = a1;
> -		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
> +		tpm_crb_ffa->direct_msg_data2 = (struct ffa_send_direct_data2){
> +			.data = { func_id, a0, a1, a2 },
> +		};
>  
>  		ret = msg_ops->sync_send_receive2(tpm_crb_ffa->ffa_dev,
>  				&tpm_crb_ffa->direct_msg_data2);
>  		if (!ret)
>  			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
>  	} else {
> -		memzero(&tpm_crb_ffa->direct_msg_data,
> -		       sizeof(struct ffa_send_direct_data));
> -
> -		tpm_crb_ffa->direct_msg_data.data1 = func_id;
> -		tpm_crb_ffa->direct_msg_data.data2 = a0;
> -		tpm_crb_ffa->direct_msg_data.data3 = a1;
> -		tpm_crb_ffa->direct_msg_data.data4 = a2;
> +		tpm_crb_ffa->direct_msg_data = (struct ffa_send_direct_data){
> +			.data1 = func_id,
> +			.data2 = a0,
> +			.data3 = a1,

Oops, lacks a2 but you probably get the idea :-)

BR, Jarkko

