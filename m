Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA41F413D
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2020 18:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgFIQoI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jun 2020 12:44:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42013 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730180AbgFIQoH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jun 2020 12:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591721045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9O6ktJVnwwW4Vd/oKJVKAa0AEa9UNwRFffaC+dkedE=;
        b=EqY8BeCgAHFSg88UYE/XenORC3ZD3v5MKTPRQ1WqZaGoBHegXTf2YcpaZYCohD/60kq/2/
        2fJd5lbqfA3ifI0tBgG8ddl3YuzUIiU5FbyOkUu79IZ8h0v53JL7ErM+efMFZnfazbWJZG
        nrjlFFXYOJnsjR1NLHYSXjcrcnMznOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-Nu1i9sWhOYq7S2BC7VlD7Q-1; Tue, 09 Jun 2020 12:44:03 -0400
X-MC-Unique: Nu1i9sWhOYq7S2BC7VlD7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EB90835B40;
        Tue,  9 Jun 2020 16:44:02 +0000 (UTC)
Received: from x2.localnet (ovpn-113-152.phx2.redhat.com [10.3.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B988E60C1D;
        Tue,  9 Jun 2020 16:43:58 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     linux-audit@redhat.com, zohar@linux.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] IMA: Add audit log for failure conditions
Date:   Tue, 09 Jun 2020 12:43:58 -0400
Message-ID: <3776526.Vj75JV9fuy@x2>
Organization: Red Hat
In-Reply-To: <ada45440-aefd-a4b2-2a3b-c012872e86cb@linux.microsoft.com>
References: <20200608215343.4491-1-nramas@linux.microsoft.com> <27448076.Og45N0Lxmj@x2> <ada45440-aefd-a4b2-2a3b-c012872e86cb@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

On Tuesday, June 9, 2020 11:58:02 AM EDT Lakshmi Ramasubramanian wrote:
> On 6/9/20 8:40 AM, Steve Grubb wrote:
> > On Monday, June 8, 2020 5:53:43 PM EDT Lakshmi Ramasubramanian wrote:
> >> The final log statement in process_buffer_measurement() for failure
> >> condition is at debug level. This does not log the message unless
> >> the system log level is raised which would significantly increase
> >> the messages in the system log. Change this log message to an audit
> >> message for better triaging failures in the function.
> >> 
> >> ima_alloc_key_entry() does not log a message for failure condition.
> >> Add an audit message for failure condition in this function.
> > 
> >> Sample audit messages:
> > Wouldn't it be better to have an IMA_ERROR record type?
> 
> type "1804" is AUDIT_INTEGRITY_PCR which is used for failures to add to
> the measurement list.
> 
> >> [    8.051937] audit: type=1804 audit(1591633422.365:8): pid=1 uid=0
> >> auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
> >> op=measuring_keys cause=hashing_error(-22)
> > 
> > The audit system uses a name=value scheme to express information. This
> > last field has something in parenthesis that may need to be interpreted.
> > In its current form, we can't do this. It would require writing code to
> > special case this event, go to this field, find the first parenthesis,
> > find the second, extract what's between, and look it up.
> > 
> > It would be better if that number in parenthesis was normalized to the
> > expected way we do audit events so nothing special has to be made.
> 
> The number in parenthesis is the error code (such as ENOMEM, EINVAL,
> etc.) IMA uses this format for reporting TPM errors in one of the audit
> messages (In ima_add_template_entry()). I followed the same pattern.
> 
> Would it be better if the value for "cause" is formatted as
> 
>     cause=hashing_error_-22
> 
>     cause=alloc_entry_-12

Neither fit the name=value style that all other events follow. What would fit 
the style is something like this:

cause=hashing_error  errno=-22
 
cause=alloc_entry errno=-12

Would this be OK? Also, errno is only to illustrate. You can name it 
something else as long as there are no use case collisions with our 
dictionary of field names.

https://github.com/linux-audit/audit-documentation/blob/master/specs/fields/
field-dictionary.csv

-Steve



