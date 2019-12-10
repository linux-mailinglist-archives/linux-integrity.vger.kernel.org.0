Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBAB9118970
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 14:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLJNWk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 08:22:40 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50924 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727061AbfLJNWk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 08:22:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ACC788EE18E;
        Tue, 10 Dec 2019 05:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575984159;
        bh=U737Wd+ugwMYxWluAj2whc4/lB89qguIzpIB/LS0OuE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JDrGCWd9ilfuU7Kpg+6/Fz4VsXnrvdy8EZUPzMqtpEMZ+Hfy69MFP0i0LSl46KwAy
         2++xEpP5S1CGu3mQdeMkmsoFP/MHBvrtlzwVr776s/nu5ed+ZnNDLmZ4y1iq1Mm4F3
         NJQ8Smy8TlKYwJ5VYy3dDES9P4Nmf9XtYR/SvHms=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nLmR_to9AeCF; Tue, 10 Dec 2019 05:22:39 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1D8258EE0F8;
        Tue, 10 Dec 2019 05:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575984159;
        bh=U737Wd+ugwMYxWluAj2whc4/lB89qguIzpIB/LS0OuE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JDrGCWd9ilfuU7Kpg+6/Fz4VsXnrvdy8EZUPzMqtpEMZ+Hfy69MFP0i0LSl46KwAy
         2++xEpP5S1CGu3mQdeMkmsoFP/MHBvrtlzwVr776s/nu5ed+ZnNDLmZ4y1iq1Mm4F3
         NJQ8Smy8TlKYwJ5VYy3dDES9P4Nmf9XtYR/SvHms=
Message-ID: <1575984158.3459.6.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 3/8] oid_registry: Add TCG defined OIDS for TPM keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org
Date:   Tue, 10 Dec 2019 05:22:38 -0800
In-Reply-To: <677893f3d9a5671b4199190bf4d1d79c4d431578.camel@infradead.org>
References: <1575936272.31378.50.camel@HansenPartnership.com>
         <1575936406.31378.53.camel@HansenPartnership.com>
         <677893f3d9a5671b4199190bf4d1d79c4d431578.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-10 at 08:18 +0000, David Woodhouse wrote:
> On Mon, 2019-12-09 at 16:06 -0800, James Bottomley wrote:
> > +       /* TCG defined OIDS for TPM based keys */
> > +       OID_TPMLoadableKey,             /* 2.23.133.10.1.3 */
> > +       OID_TPMImporableKey,            /* 2.23.133.10.1.4 */
> 
> 
> There's a t missing from OID_TPMImpoTableKey. Sorry, missed that last
> time.

Heh, yes, will fix.

James

