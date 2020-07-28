Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FAD230ED6
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgG1QHA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jul 2020 12:07:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41337 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731292AbgG1QHA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jul 2020 12:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595952419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+gquV6V93SZjNhpxmQp1P7xpjOdqg2rKp5124tI0vU=;
        b=MX+dtKIrzFtokLVKjGpdlnwUVcDHXJkkUrtw6Uw5z07PXTPqVRJJWnZbUu3hE4l+MG4FI2
        w0gvZRLY8HTIP+m/Sy3IuqIqxVMXe+0iMs/JP36ekNWpeNfP4+TUQ5tdD7vuYC8WXwNs4V
        WoPMDurhwY2dv+zAXP2lw1vz6zOXbDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-wqHAHkFqOp6s6jbiuk_hkA-1; Tue, 28 Jul 2020 12:06:55 -0400
X-MC-Unique: wqHAHkFqOp6s6jbiuk_hkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FACB801E6A;
        Tue, 28 Jul 2020 16:06:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.181])
        by smtp.corp.redhat.com (Postfix) with SMTP id 18C4F1001B2C;
        Tue, 28 Jul 2020 16:06:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 28 Jul 2020 18:06:52 +0200 (CEST)
Date:   Tue, 28 Jul 2020 18:06:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 1/4] [RFC] fs/trampfd: Implement the trampoline file
 descriptor API
Message-ID: <20200728160649.GB9972@redhat.com>
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <20200728131050.24443-2-madvenka@linux.microsoft.com>
 <20200728145013.GA9972@redhat.com>
 <dc41589a-647a-ba59-5376-abbf5d07c6e7@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc41589a-647a-ba59-5376-abbf5d07c6e7@linux.microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 07/28, Madhavan T. Venkataraman wrote:
>
> I guess since the symbol is not used by any modules, I don't need to
> export it.

Yes,

Oleg.

