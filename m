Return-Path: <linux-integrity+bounces-1016-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9148477BA
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Feb 2024 19:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFC51F236E4
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Feb 2024 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F279714D45D;
	Fri,  2 Feb 2024 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="C1EzK28n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4A7148FEE;
	Fri,  2 Feb 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899128; cv=none; b=Mp5U7DtRjG1jj31AEdLO6NsjHW/X45N63IU0p70DWEuJCM4BiwpsUFIiWMULNUFo9y2g2Yhgmadf7qLVzj5QBimLynOkdiZtkgeV+Ta8EXLHC/UjIPg1v9maft7KlK9a/2Nl+YqNgOap5sazEKaPVYD3CTTW0QMxaMhmTAj2yUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899128; c=relaxed/simple;
	bh=wLDjYYqTwt6iSXhJWzTFjILPM/y5EXO2hrTVV/q/cyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3MIFx+DO/7u9v4x0aB11Jaa5axFRl0xI7T2rUJ4s2EYZZ5ZamJp2XWNa6noBjJmNgE5PWmAlTYlvCSdDL5XHpZxflf4HBCbgAiz+KkDz31AskgH1AY4Dxj2vflM60VAguet+DA9y7ZU5+LTBGZ5FEhp1tkjELRu39qyj0lQ+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=C1EzK28n; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wOU6zPX1+oiWpUBP+WuuhoH+zslx0LLQn2VG+zxJD7M=; b=C1EzK28n89VPz62vMZUd57+DSC
	aGb2/wvVX15uq3PSkwLPH9yWE0S+CuHDhm57tPu7vLkbpUsl9NfmHbdsgoVdBpXoSE5wGHkJChwtW
	7N9MVlNsTgJdB0GYkOcH5iNTUDVhP2SZsyx+H0PdGdvkm2n1W2oXyrw3Lr/TlBs4ES2TABF3H8uns
	KUYylgU/UpwaYzkQ0eI7KWi2AnpSn8l8AQqzlBUQV5eJjvR7gCWlm1QYmcqYaAiQtwXy5zgwMewme
	TbT9Ybr3etsKWaomh0xAodRZpBqt7q/jw8C3KMseMHK53NmMbqHdmYL3D6TQL5A1Cddc3uZJCn9VD
	NMEkW1zQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVyQz-004Auq-38;
	Fri, 02 Feb 2024 18:38:42 +0000
Date: Fri, 2 Feb 2024 18:38:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-unionfs@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
Message-ID: <20240202183841.GF2087318@ZenIV>
References: <20240202110132.1584111-1-amir73il@gmail.com>
 <20240202110132.1584111-3-amir73il@gmail.com>
 <20240202160509.GZ2087318@ZenIV>
 <20240202161601.GA976131@ZenIV>
 <063577b8-3d7f-4a7f-8ed7-332601c98122@linux.ibm.com>
 <20240202182732.GE2087318@ZenIV>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202182732.GE2087318@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 06:27:32PM +0000, Al Viro wrote:

> 	Think what happens if you fetch ->len in state prior to
> rename and ->name - after.  memcpy() from one memory object
> with length that matches another, UAF right there.

	s/UAF/fairly easy oops/ - you can end up fetching past the end of
page that hosts kmalloc'ed object, and there's no promise that anything
will be mapped there.  I really need more coffee...

