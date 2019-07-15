Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC9869C4C
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 22:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfGOUEK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 16:04:10 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:56886 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbfGOUEK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 16:04:10 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 120AB72CA65;
        Mon, 15 Jul 2019 23:04:08 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id E07BF4A4A29;
        Mon, 15 Jul 2019 23:04:07 +0300 (MSK)
Date:   Mon, 15 Jul 2019 23:04:07 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v1 4/5] ima-evm-utils: Fix file2bin stat and fopen
 relations
Message-ID: <20190715200407.dfltjurut4ennd6g@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190712212833.29280-1-vt@altlinux.org>
 <20190712212833.29280-4-vt@altlinux.org>
 <1563217774.4539.146.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1563217774.4539.146.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Jul 15, 2019 at 03:09:34PM -0400, Mimi Zohar wrote:
> On Sat, 2019-07-13 at 00:28 +0300, Vitaly Chikunov wrote:
> > @@ -186,18 +187,32 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
> > 
> >  	log_info("Reading to %s\n", name);
> > 
> > -	len = get_filesize(name);
> >  	fp = fopen(name, "r");
> >  	if (!fp) {
> >  		log_err("Failed to open: %s\n", name);
> >  		return NULL;
> >  	}
> > +	if (fstat(fileno(fp), &stats) == -1) {
> > +		log_err("Failed to fstat: %s (%s)\n", name, strerror(errno));
> > +		fclose(fp);
> > +		return NULL;
> > +	}
> > +	len = stats.st_size;
> > +
> >  	data = malloc(len);
> > -	if (!fread(data, len, 1, fp))
> > -		len = 0;
> > +	if (!data) {
> > +		log_err("Failed to malloc %zu bytes: %s\n", len, name);
> 
> Missing "free(data)"

In the next patch set I will apply all your suggestions except this one,
because this is return where data was not allocated.


> > +		fclose(fp);
> > +		return NULL;
> > +	}
> > +	if (fread(data, len, 1, fp) != len) {
> > +		log_err("Failed to fread %zu bytes: %s\n", len, name);
> > +		fclose(fp);
> 
> and here
> > +		return NULL;
> > +	}
> >  	fclose(fp);
> > 
> > -	*size = len;
> > +	*size = (int)len;
> >  	return data;
> >  }
> > 
