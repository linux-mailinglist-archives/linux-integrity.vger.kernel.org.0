Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF451FA379
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 00:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgFOWXt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 18:23:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44929 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726660AbgFOWXp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 18:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ZUPfRcXkYcNh8btCoccdJZ4/n8L7JuZDFt9dxhVoRY=;
        b=NKLcD6NqxqXIPKJWbeZJAbqN0RZmTki3ORGohhX8jkSNiDiWDhTj2SDEuahcWZApBg8fyR
        7Z+sKfrhwYJ9/3082pHc5Zc8BJzC+IL+LOqApS2EmtWbs/tOV97nyXGMeVdLpGpSoLbY+c
        66gxW9LJJV50NyY3uRbt2Wt4De0czlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-ackfh9KUMRKa6acvAk4UyQ-1; Mon, 15 Jun 2020 18:23:39 -0400
X-MC-Unique: ackfh9KUMRKa6acvAk4UyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E9FE803313;
        Mon, 15 Jun 2020 22:23:38 +0000 (UTC)
Received: from x2.localnet (ovpn-114-75.phx2.redhat.com [10.3.114.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E48F10002BC;
        Mon, 15 Jun 2020 22:23:31 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, paul@paul-moore.com,
        rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
Date:   Mon, 15 Jun 2020 18:23:31 -0400
Message-ID: <8800031.dr63W5FlUW@x2>
Organization: Red Hat
In-Reply-To: <42482562-d74c-2678-069f-1d8ef4feffac@linux.microsoft.com>
References: <20200611000400.3771-1-nramas@linux.microsoft.com> <1591989920.11061.90.camel@linux.ibm.com> <42482562-d74c-2678-069f-1d8ef4feffac@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Friday, June 12, 2020 3:50:14 PM EDT Lakshmi Ramasubramanian wrote:
> On 6/12/20 12:25 PM, Mimi Zohar wrote:
> > The idea is a good idea, but you're assuming that "result" is always
> > errno.  That was probably true originally, but isn't now.  For
> > example, ima_appraise_measurement() calls xattr_verify(), which
> > compares the security.ima hash with the calculated file hash.  On
> > failure, it returns the result of memcmp().  Each and every code path
> > will need to be checked.
> 
> Good catch Mimi.
> 
> Instead of "errno" should we just use "result" and log the value given
> in the result parameter?

That would likely collide with another field of the same name which is the 
operation's results. If it really is errno, the name is fine. It's generic 
enough that it can be reused on other events if that mattered.


>  From the audit field dictionary (link given below) "result" is already
> a known field that is used to indicate the result of the audited operation.
> 
> @Steve\Paul:
> Like "res" is "result" also expected to have only values "0" or "1", or
> can it be any result code?

It should only be 0 or 1. Sometime in the past it may have been the words 
success/fail. But we've been converting those as we find them.

-Steve

> https://github.com/linux-audit/audit-documentation/blob/master/specs/fields
> /field-dictionary.csv
> 
> res 	alphanumeric 	result of the audited operation(success/fail)
> 
> result 	alphanumeric 	result of the audited operation(success/fail)




