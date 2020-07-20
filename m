Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF10D226362
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 17:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgGTPeO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 11:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgGTPeN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 11:34:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E0A722CB2;
        Mon, 20 Jul 2020 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259253;
        bh=RDQvEVMo9Esg/EJN/JsDQdAebh/9O69cXGy8sr7qtf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=10CPOQGurSx5h/FlcNSzXyphPYka9pVPfb23owr4m+5VV4OMCQ+286ek39c4dacNE
         CQv2aWiUgK0BWNSu+DG/AN9JxeZqtyXgA4WBdEjsz/Ueb0Yn+1SAU+olCzXIxbzRN8
         9LCSgrA6ltGEsoKqfUy6XkxgK49kJiMSf/XXwoeg=
Date:   Mon, 20 Jul 2020 17:32:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, masahiroy@kernel.org, james.morse@arm.com,
        bhsharma@redhat.com, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com, bauerman@linux.ibm.com,
        robh@kernel.org
Subject: Re: [PATCH V3 5/6] Update the Kconfig to support carrying forward
 the IMA Measurement log and and update the setup_dtb call to add the
 linux,ima-kexec-buffer property to the DTB.
Message-ID: <20200720153217.GB1481119@kroah.com>
References: <20200720152342.337990-1-prsriva@linux.microsoft.com>
 <20200720152342.337990-6-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720152342.337990-6-prsriva@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 20, 2020 at 08:23:41AM -0700, Prakhar Srivastava wrote:
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>

Your subject line is whack.
