Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5CE2932C0
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 03:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390094AbgJTBni (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 21:43:38 -0400
Received: from namei.org ([65.99.196.166]:36570 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390076AbgJTBni (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 21:43:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 09K1hKiQ003665;
        Tue, 20 Oct 2020 01:43:20 GMT
Date:   Tue, 20 Oct 2020 12:43:20 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tom Rix <trix@redhat.com>
cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, serge@hallyn.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        dhowells@redhat.com, mortonm@chromium.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH] security: remove unneeded break
In-Reply-To: <20201019173653.527-1-trix@redhat.com>
Message-ID: <alpine.LRH.2.21.2010201243060.17044@namei.org>
References: <20201019173653.527-1-trix@redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 19 Oct 2020, trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return
> 
> Signed-off-by: Tom Rix <trix@redhat.com>


Acked-by: James Morris <jamorris@linux.microsoft.com>



-- 
James Morris
<jmorris@namei.org>

