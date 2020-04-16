Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38E1AB4BE
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 02:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgDPAYs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Apr 2020 20:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729382AbgDPAYp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Apr 2020 20:24:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F19C061A0C
        for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2020 17:24:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so680625plo.7
        for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2020 17:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SeqbF2N8ltIT9rT3Km/oJS9FanobWLGw2yefT4jBIs8=;
        b=FXxvnOWPum8Qy55BYc47z5QCoZaPBmDD51OVUpHLwMeBTIFoZquqTAL1PxlwuBliXe
         Urc0bXmHLRd0I1ibTuaATXYtFjEin6pzCtO085ymg18tlOxKWPQS4Iql6IfgXOtLRcHY
         8iZrgCa0/CXsBqlhpbLgvxSTax/i45UYzi0mqxnJWBC/8Em+oCD3VHY7bQcH6PafsIK+
         Qg7bOHWVLiOjIsIvQyBAOHx4UlMGR3vG75ssp30QlH1ZMlk7Kk3xmZqr65lPoHWhQz99
         O86uaxIlRb1jzQ5z7++zJLYz/w24kcfINLdQo9G7VnaVNTN2QneNgPZQANQ+kTDWdqha
         PdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SeqbF2N8ltIT9rT3Km/oJS9FanobWLGw2yefT4jBIs8=;
        b=YRO8r03aehvM70ooMBJk/e6SFfzE/Islwvf8S/odtUuF/tktItWFTXhNHVyLLH2AyG
         /lcgo3RdZoqObPYFqDFSjZIbhCDsi4X+kbGpmLDwP76QDO69ZrIj0E29ZZZdFv1+ZBFV
         RfjQUBni5IJg8hzbdTTyZvhaOUHQyROXGllP7qjBjjSeSjnfFXctv3pS0IR3+Ew9fGqp
         5EWLiNFyamSu5kvFdyr6g3SiPEUcgJjRjakmhkUsjuBF62IEq8q2GHv5LD7k9/5TCfKV
         uWS/3OIJO3DTfoiv/6Ty36RmOuqrBVvg/jMmL3oxqANAd4matuD5Fqeb/wV7aPReTSG7
         Ku+Q==
X-Gm-Message-State: AGi0Puaaz28vJtFWyCJVmZROwekvMqyVIDMshUzm+J/6EIcASBtCVX6M
        zgn87D/nJfEF19f9HbKT+c6LwQ==
X-Google-Smtp-Source: APiQypJkYEih30DgfAdTPgT6Usmz6yUqOSeHuq3cdpc3ejFXy7fMPy7amNQbCzbStUKagfqtH3WuDg==
X-Received: by 2002:a17:90a:30e7:: with SMTP id h94mr1805019pjb.186.1586996684650;
        Wed, 15 Apr 2020 17:24:44 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:b0c6])
        by smtp.gmail.com with ESMTPSA id 79sm10879377pgd.62.2020.04.15.17.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 17:24:43 -0700 (PDT)
Date:   Wed, 15 Apr 2020 17:24:42 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Message-ID: <20200416002442.GB673482@vader>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
 <1586994699.3931.18.camel@HansenPartnership.com>
 <20200416001605.GA673482@vader>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20200416001605.GA673482@vader>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 15, 2020 at 05:16:05PM -0700, Omar Sandoval wrote:
> On Wed, Apr 15, 2020 at 04:51:39PM -0700, James Bottomley wrote:
> > On Wed, 2020-04-15 at 15:45 -0700, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > We've encountered a particular model of STMicroelectronics TPM that
> > > transiently returns a bad value in the status register. This causes
> > > the kernel to believe that the TPM is ready to receive a command when
> > > it actually isn't, which in turn causes the send to time out in
> > > get_burstcount(). In testing, reading the status register one extra
> > > time convinces the TPM to return a valid value.
> > 
> > Interesting, I've got a very early upgradeable nuvoton that seems to be
> > behaving like this.
> 
> I'll attach the userspace reproducer I used to figure this out. I'd be
> interested to see if it times out on your TPM, too. Note that it bangs
> on /dev/mem and assumes that the MMIO address is 0xfed40000. That seems
> to be the hard-coded address for x86 in the kernel, but just to be safe
> you might want to check `grep MSFT0101 /proc/iomem`.

Forgot to attach it, of course...

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test_tpm_tis.c"

#include <fcntl.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>

enum tis_access {
	TPM_ACCESS_VALID = 0x80,
	TPM_ACCESS_ACTIVE_LOCALITY = 0x20,
	TPM_ACCESS_REQUEST_PENDING = 0x04,
	TPM_ACCESS_REQUEST_USE = 0x02,
};

enum tis_status {
	TPM_STS_VALID = 0x80,
	TPM_STS_COMMAND_READY = 0x40,
	TPM_STS_GO = 0x20,
	TPM_STS_DATA_AVAIL = 0x10,
	TPM_STS_DATA_EXPECT = 0x08,
};

#define TPM_ACCESS(l)                   (0x0000 | ((l) << 12))
#define TPM_STS(l)                      (0x0018 | ((l) << 12))

int main(void)
{
	int fd;
	void *map;
	volatile uint8_t *access;
	volatile uint8_t *sts;
	unsigned long long i;

	fd = open("/dev/mem", O_RDWR | O_DSYNC);
	if (fd == -1) {
		perror("open");
		return EXIT_FAILURE;
	}
	map = mmap(NULL, 0x5000, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		   0xfed40000);
	if (map == MAP_FAILED) {
		perror("mmap");
		return EXIT_FAILURE;
	}
	access = (uint8_t *)map + TPM_ACCESS(0);
	sts = (uint8_t *)map + TPM_STS(0);

	i = 0;
	for (;;) {
		struct timespec stop, now;
		uint32_t burstcnt;
		uint8_t sts_read;

		*access = TPM_ACCESS_REQUEST_USE;
		while ((*access & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) !=
		       (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID))
			;

		sts_read = *sts;
#if 0
		if (sts_read == 0xff)
			sts_read = *sts;
#endif
		if (!(sts_read & TPM_STS_COMMAND_READY)) {
			*sts = TPM_STS_COMMAND_READY;
			while (!(*sts & TPM_STS_COMMAND_READY))
				;
		}

		clock_gettime(CLOCK_MONOTONIC, &stop);
		stop.tv_sec += 1;
		for (;;) {
			burstcnt = ((*(volatile uint32_t *)sts) >> 8) & 0xffff;
			if (burstcnt)
				break;
			clock_gettime(CLOCK_MONOTONIC, &now);
			if (now.tv_sec > stop.tv_sec ||
			    (now.tv_sec == stop.tv_sec &&
			     now.tv_nsec >= stop.tv_nsec)) {
				fprintf(stderr, "Timed out after %llu iterations\n", i);
				i = 0;
				break;
			}
		}

		*access = TPM_ACCESS_ACTIVE_LOCALITY;
		while ((*access & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) !=
		       TPM_ACCESS_VALID)
			;
		i++;
	}

	return EXIT_SUCCESS;
}

--J2SCkAp4GZ/dPZZf--
