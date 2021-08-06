Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0B63E2983
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Aug 2021 13:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbhHFL0Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Aug 2021 07:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242954AbhHFL0P (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Aug 2021 07:26:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6BA0611BF;
        Fri,  6 Aug 2021 11:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628249160;
        bh=4Fo6p8+27vB10eSi5EnFr+DlDl1Kc/fpWx0M207Bmjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2ARdiL6hRUSsEC+02m54kcxLGtCPaRXnZp72wwAR72UNLgAGIY0F0WcVNGsuAjPi
         1S9vWRmUv1otO1ftd54D+inSb5I/0CPiClkR1SRu3vD8dhAGF1MyAscamHxZnqtrfx
         a956VO7CGzNulJSP6gScCFB4RoiJlN26ZYehTiR4rFSC9jB/ZwpwRcgw0Rf9ZMDHwP
         u9X3eCuOuJzwx9NOXlXKUllTaq2V9dMfAb0LaDSBdaQ3yZpLbbD0zm45YdZlqRLFUa
         cvp7D3TJYzP9g9jg1hGpRFIGskSd/OMJoAXvO4/pzgyneTDA7egk5V9APtSNxN/0aZ
         Xv4F7wq69TKVA==
Date:   Fri, 6 Aug 2021 14:25:57 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] tpm: ibmvtpm: Rename tpm_process_cmd to
 tpm_status and define flag
Message-ID: <20210806112557.y7q2av6pk7r4xorm@kernel.org>
References: <20210805215256.1293987-1-stefanb@linux.vnet.ibm.com>
 <20210805215256.1293987-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805215256.1293987-2-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 05, 2021 at 05:52:55PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Rename the field tpm_processing_cmd to tpm_status in ibmvtpm_dev and set
> the TPM_STATUS_BUSY flag while the vTPM is busy processing a command.
> 
> Fixes: 6674ff145eef ("tpm_ibmvtpm: properly handle interrupted packet receptions")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Nayna Jain <nayna@linux.ibm.com>
> Cc: George Wilson <gcwilson@linux.ibm.com>

Please put the bug fix first because otherwise it will be dependent of this
patch, which is bad thing when it comes to backporting.

/Jarkko
