Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DAD39A989
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 19:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFCRuA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 13:50:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37362 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhFCRt7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 13:49:59 -0400
Received: from nramas-ThinkStation-P520 (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id C024620B7178;
        Thu,  3 Jun 2021 10:48:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C024620B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622742494;
        bh=/O+3cuUTwyhVTBRpRJNun3gW8d6RZECOYc6LABWyTOM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sR0EiqivNr6/CHvpvyEaC0bb4nYshSaC7upldcWL9S0Mm74+dPRhcpfohglhJWniy
         OtEfViVOC1d6wRNBDeLqlyWcyYdELLwmAaFFUdvu8uKqRK3AQK7ujuxajecmjzRbLi
         65H77bmVpXgS8c+1FPgzYpvECX1gIZ8+cXisMsGk=
Message-ID: <dcfa5b43436be61d79c5c3d842a147d01f896bbb.camel@linux.microsoft.com>
Subject: Re: [RFC PATCH 2/2] evm: output EVM digest calculation info needed
 for debugging
From:   nramas <nramas@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Russell Coker <russell@coker.com.au>
Date:   Thu, 03 Jun 2021 10:48:14 -0700
In-Reply-To: <f29c8302fbb83fa05cf4cddb48144e32b14a6851.camel@linux.ibm.com>
References: <20210603151819.242247-1-zohar@linux.ibm.com>
         <20210603151819.242247-3-zohar@linux.ibm.com>
         <a994cedd0b2a07faf8d1949448ec9c14b3dba34c.camel@linux.microsoft.com>
         <f29c8302fbb83fa05cf4cddb48144e32b14a6851.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-06-03 at 12:55 -0400, Mimi Zohar wrote:
> 
> On Thu, 2021-06-03 at 09:34 -0700, nramas wrote:
> > > +void evm_bin2hex_print(const char *prefix, const void *src,
> > > size_t
> > > count);
> > >  
> > 
> > For evm_bin2hex_print() can we could do the following in evm.h?
> > 
> > #ifdef DEBUG
> > void evm_bin2hex_print(const char *prefix, const void *src, size_t
> > count);
> > #else
> > void evm_bin2hex_print(const char *prefix, const void *src, size_t
> > count) {}
> > #endif /* DEBUG */
> 
> Yes, if we decide that it needs to be based on DEBUG, this would be
> the
> proper way of doing it.  However, since there's nothing really
> private
> here, it's just displaying the security xattrs and other file
> metadata,
> should enabling/disabling the debugging be runtime
> configurable?   Kind
> of like how print_hex_dump() relies on loglevel.  Or should it be
> more
> granular?
> 

I read "Documentation/admin-guide/dynamic-debug-howto.rst". I think
dynamically enabling/disabling, like how print_hex_dump() does, would
be better for evm_bin2hex_print() as well.

thanks,
 -lakshmi
 

