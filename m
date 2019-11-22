Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E557310780B
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Nov 2019 20:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKVTcd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Nov 2019 14:32:33 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45942 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbfKVTcd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Nov 2019 14:32:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6EF3A8EE10C;
        Fri, 22 Nov 2019 11:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574451152;
        bh=xdLz5DF3jZUJH3dAWBzid+6iO9QipRNxmg3J/qvCpvY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=V9radRWRD+0oglBjw8cBB1scw4eXeG1oRV4+i06VT7g3zYC4a2kbacGgHzn16DdTQ
         RRuw+OOPhJvscBiBwt80vzIFKduYtUfBKSbscgyJjjdCiM5gkIj7Y2XN13RVHZXRpE
         IEkHr+zM+PmolQTQfmyyOc1BxYauoPMGii7y1XY0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jYutBcUoMBku; Fri, 22 Nov 2019 11:32:32 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D61C48EE0EF;
        Fri, 22 Nov 2019 11:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574451152;
        bh=xdLz5DF3jZUJH3dAWBzid+6iO9QipRNxmg3J/qvCpvY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=V9radRWRD+0oglBjw8cBB1scw4eXeG1oRV4+i06VT7g3zYC4a2kbacGgHzn16DdTQ
         RRuw+OOPhJvscBiBwt80vzIFKduYtUfBKSbscgyJjjdCiM5gkIj7Y2XN13RVHZXRpE
         IEkHr+zM+PmolQTQfmyyOc1BxYauoPMGii7y1XY0=
Message-ID: <1574451150.11063.3.camel@HansenPartnership.com>
Subject: Re: IMA: Data included in the key measurement
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, dhowells@redhat.com
Cc:     James Morris <jamorris@linuxonhyperv.com>
Date:   Fri, 22 Nov 2019 11:32:30 -0800
In-Reply-To: <19554a75-06c3-f234-f27e-25f65dbecd1f@linux.microsoft.com>
References: <19242774-688e-58ff-40f8-e346d6ba4339@linux.microsoft.com>
         <1574354333.3277.27.camel@HansenPartnership.com>
         <b4257d08-f6cf-19a0-f6f0-99c962ededac@linux.microsoft.com>
         <1574439451.3331.14.camel@HansenPartnership.com>
         <19554a75-06c3-f234-f27e-25f65dbecd1f@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-11-22 at 09:39 -0800, Lakshmi Ramasubramanian wrote:
> On 11/22/19 8:17 AM, James Bottomley wrote:
> 
> Thanks for the info James. I'll investigate further.

It strikes me that for attestation purposes, the hash of the
TBSCertificate, which is the thing that the issuer signs so we have it
anyway (well modulo us wanting a different hash algorithm), is a
complete and unique identifier for the certificate; can't we just use
that ... and perhaps we should add it to the ids stored in the key
payload[2]?

James

