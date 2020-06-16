Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D331FBAA8
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 18:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbgFPPnn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 11:43:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21384 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730711AbgFPPnl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 11:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592322220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oKDGWEKwqPpKFVbswFpUDNbyYl/9csGc/AghQtdbXr0=;
        b=aLzflMdMtY2qr77jmbXU9qPhQwOuTGCbCs1V36CF/wnrZYMoJa9lMlAjYVEGBo/VnYeUwa
        5C+8U0FGeZzckm8h4ieOnEq68tPMV8vpm+ysMAmzCnodxFU8s87yAqKEUWv5fRHKNrmQjB
        c1UcmVNVBQPlrZhAV3X0BiRtlPjqob8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-18RYIHL_PyO2hLSMA5unqA-1; Tue, 16 Jun 2020 11:43:36 -0400
X-MC-Unique: 18RYIHL_PyO2hLSMA5unqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5B1910AEA20;
        Tue, 16 Jun 2020 15:43:34 +0000 (UTC)
Received: from x2.localnet (ovpn-113-82.phx2.redhat.com [10.3.113.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 777BE1001B07;
        Tue, 16 Jun 2020 15:43:28 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] integrity: Add result field in audit message
Date:   Tue, 16 Jun 2020 11:43:26 -0400
Message-ID: <41911815.FMGa2a4QOz@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhTmShh8ggdjLKf_ciL6fDt3ZH59BXaXMAgd8LFzqVj6rQ@mail.gmail.com>
References: <20200613022633.3129-1-nramas@linux.microsoft.com> <CAHC9VhTmShh8ggdjLKf_ciL6fDt3ZH59BXaXMAgd8LFzqVj6rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Monday, June 15, 2020 6:51:22 PM EDT Paul Moore wrote:
> On Fri, Jun 12, 2020 at 10:26 PM Lakshmi Ramasubramanian
> 
> <nramas@linux.microsoft.com> wrote:
> > Result code is not included in the audit messages logged by
> > the integrity subsystem. Add "result" field in the audit messages
> > logged by the integrity subsystem and set the value to the result code
> > passed to integrity_audit_msg() in the "result" parameter.
> > 
> > Sample audit message:
> > 
> > [    6.284329] audit: type=1804 audit(1591756723.627:2): pid=1 uid=0
> > auid=4294967295 ses=4294967295 subj=kernel op=add_boot_aggregate
> > cause=alloc_entry comm="swapper/0" name="boot_aggregate" res=0
> > result=-12
> > 
> > [    8.085456] audit: type=1802 audit(1592005947.297:9): pid=1 uid=0
> > auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
> > op=policy_update cause=completed comm="systemd" res=1 result=0
> > 
> > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > ---
> > 
> >  security/integrity/integrity_audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> If we can't use "res=" to carry more than 0/1 then this seems reasonable.

Paul,

But we can't do this. The field name dictionary says this is used to convey 
success/fail. It is hard coded in the field interpretation table to look for 
0/1 and interpret that. Interpeting this field will now produce an error 
message. And "result" is a searchable field.

As I suggested a few emails back, let's just use errno or something not 
already taken in the dictionary. NACK.

-Steve

> Acked-by: Paul Moore <paul@paul-moore.com>
> 
> > diff --git a/security/integrity/integrity_audit.c
> > b/security/integrity/integrity_audit.c index 5109173839cc..84002d3d5a95
> > 100644
> > --- a/security/integrity/integrity_audit.c
> > +++ b/security/integrity/integrity_audit.c
> > @@ -53,6 +53,6 @@ void integrity_audit_msg(int audit_msgno, struct inode
> > *inode,> 
> >                 audit_log_untrustedstring(ab, inode->i_sb->s_id);
> >                 audit_log_format(ab, " ino=%lu", inode->i_ino);
> >         
> >         }
> > 
> > -       audit_log_format(ab, " res=%d", !result);
> > +       audit_log_format(ab, " res=%d result=%d", !result, result);
> > 
> >         audit_log_end(ab);
> >  
> >  }
> > 
> > --
> > 2.27.0




