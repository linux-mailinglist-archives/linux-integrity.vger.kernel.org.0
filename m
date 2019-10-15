Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99FFBD7CDC
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2019 19:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfJOREx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Oct 2019 13:04:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46263 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfJOREx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 13:04:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so12846942pfg.13
        for <linux-integrity@vger.kernel.org>; Tue, 15 Oct 2019 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mqEuhvlTqp14S8mH0iL/2lPaSLcfm7VaqiIgGEqKWMk=;
        b=D4ShOz3TQih7NmaeEtKqlb0TSvP7KSMCGM5nw1Meu4R/O3TiGC5gvdoT71EV93zC00
         o3P+2MuiEwb0x991JYgWp8RdsnPrBq2eyzFNkZDCqtcKJGPHCCnvf1W4QrN3VlTGqVij
         zRnQqqWnEEhxFpafxdGrn/uS+QEnde8vqvC29bWx5046vcTH9kQMcaZetBfWiLZkgUN8
         hjnNumZcvEZx1UUhlUQZRyKKjXyIKIV7KPwAirH1UN6EHwD6GCbdBelziTqbqa4CSk17
         wk9w51KIJ5QnnvrCOdhBE3ZGCWGrQSqbFk5WguDuNE5KJN3rwt7Xu/CYbFfh28G9P7bq
         JqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mqEuhvlTqp14S8mH0iL/2lPaSLcfm7VaqiIgGEqKWMk=;
        b=OwU7uQkbifpfY7Hx+/fEoLnV23rqOnfVqXYWVjWoPjMQzBgJWF97J6hvIc38SLtFjH
         dXJIKVFSt27lAj21sHkhlMvsw8kPslW3i7N0Mbx/yphfI8GdTXMCgJG+fWbmfve7hrOO
         jGrZYbtWlqe07CuxqaJJT9blLFttPMZy6dfdNlnLdgmFiyjcn8CPwfqQQe1RttfrBH5D
         ofH2VDYQuEymiaCgR/6+5Plz29nbugtjArkzJ2vljhVcRD4SC84EdGZRelWm5FrkOg70
         xkbkxtF80s8uYZ8EtZYg0wmYLTQhfAktHnLyjZIqvTTecJgqdJ0eP3MN9vMy6TwD392V
         +BUA==
X-Gm-Message-State: APjAAAU0dUWg5rFu+cc770guWRqE4cTCLm65jSbgg5EUYiyquVeGZ0oX
        5FX7CnEEP7+PlYqGv+TBFZ2n1g==
X-Google-Smtp-Source: APXvYqyhmYECdW43MhFhTN7//aeS41RHJ10Z2yDljk0yyhfJjbjM1mu84/PDw5uP6av+TuznHBaj2A==
X-Received: by 2002:a63:6949:: with SMTP id e70mr39295261pgc.226.1571159092733;
        Tue, 15 Oct 2019 10:04:52 -0700 (PDT)
Received: from ziepe.ca ([72.143.229.181])
        by smtp.gmail.com with ESMTPSA id t125sm26439052pfc.80.2019.10.15.10.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 10:04:51 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKQFe-0001TU-HP; Tue, 15 Oct 2019 14:04:50 -0300
Date:   Tue, 15 Oct 2019 14:04:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        David Safford <david.safford@ge.com>,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Salt tpm_get_random() result with get_random_bytes()
Message-ID: <20191015170450.GB5444@ziepe.ca>
References: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 15, 2019 at 03:47:02PM +0300, Jarkko Sakkinen wrote:
> Salt the result that comes from the TPM RNG with random bytes from the
> kernel RNG. This will allow to use tpm_get_random() as a substitute for
> get_random_bytes().  TPM could have a bug (making results predicatable),
> backdoor or even an inteposer in the bus. Salting gives protections
> against these concerns.

Seems like a dangerous use case, why would any kernel user that cared
about quality of randomness ever call a tpm_* API to get quality
random data?

Jason
