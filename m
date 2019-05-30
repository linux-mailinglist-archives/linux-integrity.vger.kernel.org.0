Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33925302F0
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2019 21:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfE3Tnm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 May 2019 15:43:42 -0400
Received: from namei.org ([65.99.196.166]:35486 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfE3Tnm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 May 2019 15:43:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4UJhQ8I031928;
        Thu, 30 May 2019 19:43:26 GMT
Date:   Fri, 31 May 2019 05:43:26 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 18/22] docs: security: trusted-encrypted.rst: fix code-block
 tag
In-Reply-To: <9c8e63bba3c3735573ab107ffd65131db10e1d2e.1559171394.git.mchehab+samsung@kernel.org>
Message-ID: <alpine.LRH.2.21.1905310543170.26428@namei.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org> <9c8e63bba3c3735573ab107ffd65131db10e1d2e.1559171394.git.mchehab+samsung@kernel.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 29 May 2019, Mauro Carvalho Chehab wrote:

> The code-block tag is at the wrong place, causing those
> warnings:
> 
>     Documentation/security/keys/trusted-encrypted.rst:112: WARNING: Literal block expected; none found.
>     Documentation/security/keys/trusted-encrypted.rst:121: WARNING: Unexpected indentation.
>     Documentation/security/keys/trusted-encrypted.rst:122: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/security/keys/trusted-encrypted.rst:123: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

