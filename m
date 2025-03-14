Return-Path: <linux-integrity+bounces-5285-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D0A6147F
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1307A3D60
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C941FF5E9;
	Fri, 14 Mar 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5Upj3kT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47017579;
	Fri, 14 Mar 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964756; cv=none; b=Ld/BQw/BdAbAUJ1gYMie2rgE8OF/dIDSqoFHobAlkv9dcED8rdppdjTq309we2l2GRatEfAjipYAPIJXONhxU4JlXHxLBXj0A+BzZWVzikafa2yjdtPgLR/KymlQL0Ax/zMbhk5Sd9uh1WcWtB3R9gLZ3ruvapsduZ4yNqfU8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964756; c=relaxed/simple;
	bh=Ua9D+rF5n2VjgitjQFJO+hx2rde3OWG9LIxmgDoAs3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mem79NV90/Oc65u6f6W9Q/5r9uHHERV4yTo8YXIG4Ngn4lrIMvjBzL+lZOkzlkqGFJPAmSaPL0rO0kSo1kPs/3y49qc/34gV1OIlIbG4Jk98iDOQwH8JdpmzZdCKMqX2D/583EDNzLgzsQdHwIgc1dqsMBumLE58Kk4AtM6uJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5Upj3kT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA76C4CEE3;
	Fri, 14 Mar 2025 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741964755;
	bh=Ua9D+rF5n2VjgitjQFJO+hx2rde3OWG9LIxmgDoAs3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5Upj3kTUtFGuOzqPvQj2ALgK4/Mp/yXjcWRkViEUMLQOWfnLua/EDnhUtNxQAOpt
	 1caWrY4JKmqrGbmYTtSpqiE+1tGJAXlkXCNvi8rrbl2QY9R3/nK/VGD8b+Hj/Cpt3r
	 n/LXjIUXgXLfAWXXfD1D9D4Uhez5K1sEfM1E53wWRmTMtrEYLbxybPG6ikeMctsZTA
	 RQHKjgyC9hniJnu8dqLYkfG3g8SDHEqu8OE+XuQyi7uq5DU0lX1U7at9Twt5WbPe5p
	 RrOJwAaUKsBmy+7FLCDqyKqeCdazgBZgZ3ISp/AN5dxA5TV1O97+aHv/NLohTZE7iR
	 Wh8KytVvm72iA==
Date: Fri, 14 Mar 2025 17:05:50 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, James.Bottomley@hansenpartnership.com,
	stefanb@linux.ibm.com, ardb@kernel.org, roberto.sassu@huawei.com,
	viro@zeniv.linux.org.uk, gourry@gourry.net
Subject: Re: [PATCH] MAINTAINERS: Add include/linux/tpm*.h to TPM maintainers
Message-ID: <Z9RFzkzAn1Vi76hY@kernel.org>
References: <3E528EFF1AE81A17+20250311131440.1468875-1-wangyuli@uniontech.com>
 <Z9EofB1oLBUgu05C@kernel.org>
 <F0B8DC7D8609F78E+f602292f-27ed-41e0-81d9-911174ee1da0@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F0B8DC7D8609F78E+f602292f-27ed-41e0-81d9-911174ee1da0@uniontech.com>

On Wed, Mar 12, 2025 at 02:48:51PM +0800, WangYuli wrote:
> Hi Jarkko,
> 
> On 2025/3/12 14:23, Jarkko Sakkinen wrote:
> > "Subnames" are separated with space, not with camel case.
> > 
> It's just a matter of regional cultural differences.
> 
> In my country, we don't have the concept of "Subname" in names.
> 
> We only have "Surname" and "Given name", and our convention is to put the
> surname first, followed by the given name, without a space in between.
> 
> So I don't think I need to make any changes to my sign-off.

OK, I don't really mind the order, and I did not about the white space
part.

So with that

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>


> 
> Of course, as you are the TPM maintainer, I respect your opinion, and if you
> strongly insist, I can change my sign-off but only for all future
> TPM-related commits, perhaps by using Unicode characters instead of spelling
> it out with English letters.

It's always good to get educated, no worries.

> 
> Thanks,
> 
> -- 
> 
> 王昱力
> 


BR, Jarkko

