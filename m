Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746BB58375
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0N3O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jun 2019 09:29:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfF0N3O (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jun 2019 09:29:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3C5A83F3C;
        Thu, 27 Jun 2019 13:29:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 113C2600CC;
        Thu, 27 Jun 2019 13:29:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1561640534.4101.124.camel@linux.ibm.com>
References: <1561640534.4101.124.camel@linux.ibm.com> <20190626231617.1e858da3@canb.auug.org.au> <ee503bc1-a588-81f5-47e0-1762f590662f@infradead.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     dhowells@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: linux-next: Tree for Jun 26 (security/integrity/ima/)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Thu, 27 Jun 2019 14:29:05 +0100
Message-ID: <9446.1561642145@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 27 Jun 2019 13:29:14 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi Zohar <zohar@linux.ibm.com> wrote:

> >   CC      security/integrity/ima/ima_fs.o
> > In file included from ../security/integrity/ima/ima.h:25:0,
> >                  from ../security/integrity/ima/ima_fs.c:26:
> > ../security/integrity/ima/../integrity.h:170:18: warning: ‘struct key_acl’ declared inside parameter list [enabled by default]
> >            struct key_acl *acl)
> >                   ^
> > ../security/integrity/ima/../integrity.h:170:18: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> 
> David, CONFIG_INTEGRITY_SIGNATURE is dependent on KEYS being enabled,
> but the stub functions are not.  There's now a dependency on
> key_acl().

I added a forward declaration for struct key_acl into
security/integrity/integrity.h as you can see here:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/diff/security/integrity/integrity.h?h=keys-acl&id=75ce113a1d56880e5abd37fa664ea9af399d2bcd

which might not have made it into linux-next before you used it.

David
