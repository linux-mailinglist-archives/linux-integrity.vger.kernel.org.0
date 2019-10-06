Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5CCD03D
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Oct 2019 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfJFKEC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Oct 2019 06:04:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:37636 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFKEC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Oct 2019 06:04:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2019 03:04:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,263,1566889200"; 
   d="scan'208";a="393996535"
Received: from jlogan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.4.40])
  by fmsmga006.fm.intel.com with ESMTP; 06 Oct 2019 03:03:59 -0700
Date:   Sun, 6 Oct 2019 13:03:53 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] tpm: Use GFP_KERNEL for allocating struct tpm_buf
Message-ID: <20191006095005.GA7660@linux.intel.com>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
 <20191003185103.26347-2-jarkko.sakkinen@linux.intel.com>
 <1570148716.10818.19.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570148716.10818.19.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 03, 2019 at 05:25:16PM -0700, James Bottomley wrote:
> On Thu, 2019-10-03 at 21:51 +0300, Jarkko Sakkinen wrote:
> > Switch from GFP_HIGHUSER to GFP_KERNEL. On 32-bit platforms kmap()
> > space
> > could be unnecessarily wasted because of using GFP_HIGHUSER by taking
> > a
> > page of from the highmem.
> > 
> > Suggested-by: James Bottomley <jejb@linux.ibm.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  drivers/char/tpm/tpm.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index a4f74dd02a35..d20745965350 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -297,7 +297,7 @@ static inline void tpm_buf_reset(struct tpm_buf
> > *buf, u16 tag, u32 ordinal)
> >  
> >  static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32
> > ordinal)
> >  {
> > -	buf->data_page = alloc_page(GFP_HIGHUSER);
> > +	buf->data_page = alloc_page(GFP_KERNEL);
> >  	if (!buf->data_page)
> >  		return -ENOMEM;
> 
> The kmap/kunmap needs removing as well, and now the data_page field
> isn't necessary, so it can go.  I think the result should be something
> like the below (uncompiled and untested).
> 
> James
> 
> ---
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index a7fea3e0ca86..b4f1cbf344b6 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -284,7 +284,6 @@ enum tpm_buf_flags {
>  };
>  
>  struct tpm_buf {
> -	struct page *data_page;
>  	unsigned int flags;
>  	u8 *data;
>  };
> @@ -300,20 +299,18 @@ static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  
>  static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  {
> -	buf->data_page = alloc_page(GFP_HIGHUSER);
> -	if (!buf->data_page)
> +	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> +	if (!buf->data)
>  		return -ENOMEM;
>  
>  	buf->flags = 0;
> -	buf->data = kmap(buf->data_page);
>  	tpm_buf_reset(buf, tag, ordinal);
>  	return 0;
>  }
>  
>  static inline void tpm_buf_destroy(struct tpm_buf *buf)
>  {
> -	kunmap(buf->data_page);
> -	__free_page(buf->data_page);
> +	free_page(buf->data);
>  }
>  
>  static inline u32 tpm_buf_length(struct tpm_buf *buf)
> 
> 

Care to make this a proper patch? Much better idea to do it this
way, agreed.

/Jarkko
