Return-Path: <linux-integrity+bounces-7050-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBCEB51E9F
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 19:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353F07B0E5B
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC72512EE;
	Wed, 10 Sep 2025 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktYhFJFJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736E824166E
	for <linux-integrity@vger.kernel.org>; Wed, 10 Sep 2025 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524135; cv=none; b=SY9J8fYARJnUGLFSYJmZwz37MAj+zsXHypGDy344FQkkO215mEP2ikzl8EcbdEL48msNieKxBJuyJOqZFDqE/U8xsS1qOzUrEWkmDqQQUdisO60i+kxu28iM0UGyRX8z/GAgsWO/78gzHS54TrfIGjXPLVAR0QIHwwltCB5Cg50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524135; c=relaxed/simple;
	bh=0SE67FuiNVShM87+FcEWSQlAevs1zxaADZ1TqKimem0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMDiq1a8Zj/x0ixyNMGpyTTyn1lj/QWnlRXeYB2dpK4lk7RoQ3l+cFUbO04JH/r0FB1FWSLm2utlJkQbqhjFMihoLqqVhWK+fAgmEHNG3fass0XQUNanOxipVOeH0ZirCUmyP1iHcmR1TIa973cRYbDHUIMML3yx1Ji0hdKeX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktYhFJFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED84C4CEEB;
	Wed, 10 Sep 2025 17:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757524133;
	bh=0SE67FuiNVShM87+FcEWSQlAevs1zxaADZ1TqKimem0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktYhFJFJHla/5AFmjASlpJ/Z+KJVIQzYJh6Jz/EWy6LNkizgJqpfmy1bHBm4ALsko
	 AGmj1ZS65+eQpzeH+ySkhQ6wJClL4yr5rpWUEzyjrdVvZfj+xcgPhv1bbV+HvI6Z6D
	 cmv9pg4lI8Dyw1aLK5Lg9e4IVcJDvwECvb1+yJp96ECweoPD6O/MrBsKMVBluau0DI
	 8YVJLoe8kzKntVzbkTtCDIdqOZb81bek66DMSwhr/5qB9mZvBH8wiPFnXdgQ+NuaLl
	 gkKJzt5QU4siguUFGHVLgpEW7csZnNcvgNd6ofg7W8QP3tk+QRrWbbwjvQGLyMbsdz
	 VluW5/Qbixtgw==
Date: Wed, 10 Sep 2025 20:08:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v4] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aMGwoYlvBSPLpp3z@kernel.org>
References: <20250902142429.14041-2-daleksan@redhat.com>
 <aLcl2SzTc_nTX56u@kernel.org>
 <CAG+gbFeYuxVbo+RY9Ux-zysO76Q9yiD5DfD4e4cwNxX-VgfKWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG+gbFeYuxVbo+RY9Ux-zysO76Q9yiD5DfD4e4cwNxX-VgfKWQ@mail.gmail.com>

On Tue, Sep 02, 2025 at 03:12:45PM -0400, Denis Aleksandrov wrote:
> Great, thank you Jarkko!
> 
> Could you please take a look at the most recent reply from Paul in the
> v2 thread for this patch?
> Should I move forward with the advised changes and send a v5?

Mind passing me the lore link? At least quick search could not find
(sorry).

> 
> The concerns were:
> - Adding info on how to test and debug the code to the commit message.
> - Reverting the "Blocked by OS ..." field in tpm_ppi_info[].
> - Reverting the conditional in tpm_show_tcg/vs_operations()
> and sending in a separate patch with the change. The change was
> concerning displaying the "Not Implemented" status by updating
> `ret > 0` to `ret >= 0` in the if statement.
> 
> Please let me know what you think.
> 
> Thanks again,
> Denis
> 

BR, Jarkko

