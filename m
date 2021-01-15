Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37372F823E
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 18:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbhAOR1L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 12:27:11 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:51130 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbhAOR1L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 12:27:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BD3901280891;
        Fri, 15 Jan 2021 09:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610731590;
        bh=rYHSOlgfwH4DYPp5D6X9165y63QWKKlITcx8p95s98A=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=m3xE1ewBl35LGetY2/FWMPqCUoyOS3dvppAtsjHBL+naZhxJ9CRxn3ABaLmpHimsN
         +3QQXrhtvheeNT7KFhsPPZxUZlyimRdNS9hWlIj+Tw1FvU4dkXru2qHJvpIpPMKnPq
         J124BzSgVEmauZBarKXxVgIpgJN4WfPmyo+Mnc6U=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eDK5fCppuG0u; Fri, 15 Jan 2021 09:26:30 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 551C7128088F;
        Fri, 15 Jan 2021 09:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610731590;
        bh=rYHSOlgfwH4DYPp5D6X9165y63QWKKlITcx8p95s98A=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=m3xE1ewBl35LGetY2/FWMPqCUoyOS3dvppAtsjHBL+naZhxJ9CRxn3ABaLmpHimsN
         +3QQXrhtvheeNT7KFhsPPZxUZlyimRdNS9hWlIj+Tw1FvU4dkXru2qHJvpIpPMKnPq
         J124BzSgVEmauZBarKXxVgIpgJN4WfPmyo+Mnc6U=
Message-ID: <eb2acffef1368c48b3ca2d85105ef73b31797fe7.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 1/2] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg KH <greg@kroah.com>, Joe Perches <joe@perches.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-api@vger.kernel.org
Date:   Fri, 15 Jan 2021 09:26:29 -0800
In-Reply-To: <YAGeez8OZWDXugTW@kroah.com>
References: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
         <20210113232634.23242-2-James.Bottomley@HansenPartnership.com>
         <X//55I26mxVQKKOE@kroah.com>
         <ce0ce0c5b3b66e2b1506ab9c4f10ffbbcfa648d8.camel@HansenPartnership.com>
         <YAGeez8OZWDXugTW@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-01-15 at 14:54 +0100, Greg KH wrote:
> On Thu, Jan 14, 2021 at 04:21:08PM -0800, James Bottomley wrote:
[...]
> > It looks like we already have a couple of bugs in the kernel
> > introduced by this confusion ...  return sysfs_emit() vs return
> > sysfs_emit_at() being the most tricky ...
> 
> Hm, Joe, you did the conversion to these functions (and wrote the
> api), care to review this?

A cursory glance tells me that summary_show in 
drivers/infiniband/hw/usnic/usnic_ib_sysfs.c has a problem, I think the
last = should be +=

James



