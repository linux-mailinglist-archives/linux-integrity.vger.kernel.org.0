Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E861FD8F7
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 00:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgFQWg5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 18:36:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52946 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727001AbgFQWg5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 18:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592433415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PqSlpxZ3YN58ZRJ/BXA2pFGBO/xB6CvZLuRPE0ix/fQ=;
        b=O+ovUaAV3TPXqfsmVfOFRgz8tvrp6qwDe3DYA0Y5pGELLiaxthzPdRbidNA7Fs/SBn4cT+
        82uYYJxznhc+P55G+wJq/jPUFtSoGMLPSyqRzKI5fnWE8Af+iJx0pIkbMh1O7hci3zgaTw
        MJWHp+UmDdLjj3fPnmR/BXNyskJrQBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-XNWeQA5YO767oZg56rfV3A-1; Wed, 17 Jun 2020 18:36:51 -0400
X-MC-Unique: XNWeQA5YO767oZg56rfV3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21CC91800D42;
        Wed, 17 Jun 2020 22:36:50 +0000 (UTC)
Received: from x2.localnet (ovpn-114-52.phx2.redhat.com [10.3.114.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D25BD19931;
        Wed, 17 Jun 2020 22:36:43 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com, nayna@linux.ibm.com,
        paul@paul-moore.com, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] integrity: Add errno field in audit message
Date:   Wed, 17 Jun 2020 18:36:43 -0400
Message-ID: <3369897.H5lpGJDj0b@x2>
Organization: Red Hat
In-Reply-To: <20200617204436.2226-2-nramas@linux.microsoft.com>
References: <20200617204436.2226-1-nramas@linux.microsoft.com> <20200617204436.2226-2-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wednesday, June 17, 2020 4:44:36 PM EDT Lakshmi Ramasubramanian wrote:
> Error code is not included in the audit messages logged by
> the integrity subsystem. Add "errno" field in the audit messages
> logged by the integrity subsystem and set the value to the error code
> passed to integrity_audit_msg() in the "result" parameter.
> 
> Sample audit messages:
> 
> [    6.284329] audit: type=1804 audit(1591756723.627:2): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=kernel op=add_boot_aggregate
> cause=alloc_entry comm="swapper/0" name="boot_aggregate" res=0 errno=-12
> 
> [    8.085456] audit: type=1802 audit(1592005947.297:9): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
> op=policy_update cause=completed comm="systemd" res=1 errno=0
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>

Acked-by: Steve Grubb <sgrubb@redhat.com>

> ---
>  security/integrity/integrity_audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/integrity_audit.c
> b/security/integrity/integrity_audit.c index 5109173839cc..a265024f82f3
> 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -53,6 +53,6 @@ void integrity_audit_msg(int audit_msgno, struct inode
> *inode, audit_log_untrustedstring(ab, inode->i_sb->s_id);
>  		audit_log_format(ab, " ino=%lu", inode->i_ino);
>  	}
> -	audit_log_format(ab, " res=%d", !result);
> +	audit_log_format(ab, " res=%d errno=%d", !result, result);
>  	audit_log_end(ab);
>  }




