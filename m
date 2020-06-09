Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478911F426D
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2020 19:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgFIRf2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jun 2020 13:35:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39041 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726848AbgFIRf1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jun 2020 13:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591724126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d8NE7paHe8S13knpYfX/RMXrdocBZKzMgPI9WeSOxdc=;
        b=XTzixvZfFYtKUL1Oe2VlyDKZf06IOZNPiE5eDXaCk1QwcA8dPDh0whb8cAP1b2+p2Dve05
        8dm9n7icRZ0wiNt6Eayn2glSZwYeqrkJz+shhPiXDHWjGsTP02WxtB5ma0H3UZFDJZ3CtE
        /043Q5Cd7Y96S5rDnbtt0/ny/RstZlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-XsHm8cFQNcqrth7mXB8Wzw-1; Tue, 09 Jun 2020 13:35:22 -0400
X-MC-Unique: XsHm8cFQNcqrth7mXB8Wzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4CB8107ACF2;
        Tue,  9 Jun 2020 17:35:20 +0000 (UTC)
Received: from x2.localnet (ovpn-113-152.phx2.redhat.com [10.3.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B92F19D71;
        Tue,  9 Jun 2020 17:35:14 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] IMA: Add audit log for failure conditions
Date:   Tue, 09 Jun 2020 13:35:14 -0400
Message-ID: <2006844.2enhIMKrvE@x2>
Organization: Red Hat
In-Reply-To: <20200609171555.itbllvtgjdanbbk7@madcap2.tricolour.ca>
References: <20200608215343.4491-1-nramas@linux.microsoft.com> <518a51b7-6c8d-f55f-c73a-b15abae8e0af@linux.microsoft.com> <20200609171555.itbllvtgjdanbbk7@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tuesday, June 9, 2020 1:15:55 PM EDT Richard Guy Briggs wrote:
> On 2020-06-09 10:00, Lakshmi Ramasubramanian wrote:
> > On 6/9/20 9:43 AM, Steve Grubb wrote:
> > > > The number in parenthesis is the error code (such as ENOMEM, EINVAL,
> > > > etc.) IMA uses this format for reporting TPM errors in one of the
> > > > audit
> > > > messages (In ima_add_template_entry()). I followed the same pattern.
> > > > 
> > > > Would it be better if the value for "cause" is formatted as
> > > > 
> > > > cause=hashing_error_-22
> > > > 
> > > > cause=alloc_entry_-12
> > > 
> > > Neither fit the name=value style that all other events follow. What
> > > would fit the style is something like this:
> > > 
> > > cause=hashing_error  errno=-22
> > > cause=alloc_entry errno=-12
> > > 
> > > Would this be OK? Also, errno is only to illustrate. You can name it
> > > something else as long as there are no use case collisions with our
> > > dictionary of field names.
> > > 
> > > https://github.com/linux-audit/audit-documentation/blob/master/specs/fi
> > > elds/ field-dictionary.csv
> > 
> > I am fine with this.

Thanks, this makes interpreting it a couple lines of code.

> > "errno" is currently not listed in the dictionary of audit message field
> > names (Thanks for the pointer to this one Steve)

It can be easily added.

> > Mimi - please let me know if you have any concerns with adding the
> > "result" code in "errno" field in integrity_audit_msg().
> 
> If it is added, it should be appended to the end of the record since it
> is an existing record format, then in the case of res=1, errno= should
> still be present (not swing in and out) and just contain zero.  (Or
> another value if there is a non-fatal warning?)

This is not a searchable field, so it can go anywhere. If it is searchable, 
ausearch expects ordering of other searchable fields.

-Steve


