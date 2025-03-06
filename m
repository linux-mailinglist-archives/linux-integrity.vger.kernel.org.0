Return-Path: <linux-integrity+bounces-5130-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 928AEA542D4
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 07:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B844916BE6F
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 06:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A66719E7E2;
	Thu,  6 Mar 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkXkKx12"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197D19882F
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242935; cv=none; b=j34aaQcqhoWKJ1eF62S3E5g8fZEG/hxyNlSFv19dywReTCjUbKRzIG5rgTG6rU7bDfjRBd29Jgr7CKbT84ISfmEw4pQy6JnichsFO0KM8XkER0qhnWc6Z1RXZVG9Jh90tg0hZU6Bov7ZCo1Iu7LGX8RcOcJi0cknkyiHtK3uODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242935; c=relaxed/simple;
	bh=OgVi8LZ/avO7r/TihguE885iMoKtcusZUL+VQwbS8dk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ifuCxjxnLrYwkCSfbg64wSCiFJnmLJYwfV+oefmup6q6ipj6LkU6NBa8vhPnBlSJydm9S9r1edpvTY3ecGPnoBkE3u3hoF3Q2oAkMVkIDEv69u+sJhqsrUkc59s2oBlmoCsbyoJ94uikLHo2zNchmTgAOj0tTWU08AL2P0lyClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkXkKx12; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bcad638efso1219625e9.2
        for <linux-integrity@vger.kernel.org>; Wed, 05 Mar 2025 22:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741242931; x=1741847731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx4eXhc4yqpVhI7TdTQuRC9iguxZspH9NuwtaHcC+Lc=;
        b=NkXkKx121iIVwRfnvL2NV5bLufVR3G63SPc2p4TvkVzVlrqSAO8fwb7sdoMK0GT32C
         ilASo1O5JK5ny5ODedT2PQkBlTEz9WDqL3Uw3WLQIupKoBZxhobysE7kPRTQY1s9kqa0
         rk9rvPMv44zRlZlAtGDG7EGQo/5pLiwA8PvxRhYa/g0txZI2zYLfYnN7xk2WsQQZvLOT
         Vy0eQ+j+Ktk57PekxQCGydsr068OdVmEtWspEdI+gb60MMdV+jfL1SZEn8lDPMasLGpH
         keu9Rve6CedfwPt/S7sg02dFwD7XQyy23x+MZIoajVllLg+CMTeADiVW/3vHx85yVG83
         LgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741242931; x=1741847731;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx4eXhc4yqpVhI7TdTQuRC9iguxZspH9NuwtaHcC+Lc=;
        b=BmFtv+LMOwt2yDgQE3IHUcPQQFh3OxkgsPA1fkCS4xp8l2/x9yRGVjK8uqW7WoveKA
         DdEIkktixBnuQm1W9Czv5LkhhNGY3Dn/P/3SbMf56pL4DF06YyV9u+RqOwZkO93ovPTJ
         hhKo4/wTl1zj2+seRojEoOk5Orn79gPGnM+r16IUhTsyeADskFYZJqfRsOf240PesLXx
         AVkyRaOYJzCQyIRGvCLw1Rl4+pgxbQNXfIEUBZ8YJ3pZ3yI3OgGy7JtrBUhQI8yxWIsr
         7iYgwZ6zATbu7oXUUfkWJ3jWBhl2xjGrpL4X9uX+2GmLeXwCxUb4UREluF/Ni+bP3jJ+
         rSQA==
X-Forwarded-Encrypted: i=1; AJvYcCW0OF3zfHv0sJoErCJjm/nHZVOYlpttQPC1Yxb87eZD5EH6NvWBkwGUxAXE+cXFe31GnR2JoSBjJqpgKcvSopM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQxQi8OoFIWi0S/oXGPFtPr4Eii64qk4kFObz9vR9GRzRsS/H
	Ula9dEPU2zwhHPh2c003fynnM+Fwm/Kvn2qOvd0Wsc5k18dbJ66wV120Q14cBXI=
X-Gm-Gg: ASbGncv+jV7cPSxpuIATyFF/Ob0osd9u8JMKC7Y//1qs5YpyFKj9d07fx3bPVobyjBQ
	n9Q2zMiZCYX7HPbcI6Oj9rWwY9emDFxJ0VIhxo0SF66FiZxkIwzpDsjNJW7PV3KwfWZcyukbIJa
	LvDMuFVEyxXA3fvxOU+aIF/THRTAf4jm7drDHgBnIet190tzfrrAKgPW7+gQdvXW6ZG2LLt1VcK
	OTVRDdLEzTAFzyUZEGI/M2vQGwnbkOWnuU8oWkpKcOab8cXhRU0nauuMPGw/B+E+2y88YD8dja9
	R6kKphx3dCaZxM4Mxhl0eeBE5K3UV4xrlu6ZvT3gNfdzuq5XHQ==
X-Google-Smtp-Source: AGHT+IEldEFBJ6GcJ/9AsmwidDi0MW22pFoTiX1DY3pYgmQW8PLpDd7QMPBO5UsdG2P8Z7W4b9nJlQ==
X-Received: by 2002:a05:600c:1551:b0:43b:cb0c:3556 with SMTP id 5b1f17b1804b1-43bd2af49cemr38379685e9.28.1741242930569;
        Wed, 05 Mar 2025 22:35:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd8c314asm9415525e9.10.2025.03.05.22.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 22:35:30 -0800 (PST)
Date: Thu, 6 Mar 2025 09:35:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, steven chen <chenste@linux.microsoft.com>,
	zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v9 2/7] kexec: define functions to map and unmap segments
Message-ID: <7bde870f-07eb-48a6-8b8d-edac57640775@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190351.96975-3-chenste@linux.microsoft.com>

Hi steven,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/steven-chen/ima-copy-only-complete-measurement-records-across-kexec/20250305-031719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20250304190351.96975-3-chenste%40linux.microsoft.com
patch subject: [PATCH v9 2/7] kexec: define functions to map and unmap segments
config: x86_64-randconfig-161-20250306 (https://download.01.org/0day-ci/archive/20250306/202503061449.gbVGafZc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503061449.gbVGafZc-lkp@intel.com/

smatch warnings:
kernel/kexec_core.c:896 kimage_map_segment() error: uninitialized symbol 'dest_page_addr'.

vim +/dest_page_addr +896 kernel/kexec_core.c

bf06eab7ae0f04 steven chen 2025-03-04  870  void *kimage_map_segment(struct kimage *image,
bf06eab7ae0f04 steven chen 2025-03-04  871  			 unsigned long addr, unsigned long size)
bf06eab7ae0f04 steven chen 2025-03-04  872  {
bf06eab7ae0f04 steven chen 2025-03-04  873  	unsigned long eaddr = addr + size;
bf06eab7ae0f04 steven chen 2025-03-04  874  	unsigned long src_page_addr, dest_page_addr;
bf06eab7ae0f04 steven chen 2025-03-04  875  	unsigned int npages;
bf06eab7ae0f04 steven chen 2025-03-04  876  	struct page **src_pages;
bf06eab7ae0f04 steven chen 2025-03-04  877  	int i;
bf06eab7ae0f04 steven chen 2025-03-04  878  	kimage_entry_t *ptr, entry;
bf06eab7ae0f04 steven chen 2025-03-04  879  	void *vaddr = NULL;
bf06eab7ae0f04 steven chen 2025-03-04  880  
bf06eab7ae0f04 steven chen 2025-03-04  881  	/*
bf06eab7ae0f04 steven chen 2025-03-04  882  	 * Collect the source pages and map them in a contiguous VA range.
bf06eab7ae0f04 steven chen 2025-03-04  883  	 */
bf06eab7ae0f04 steven chen 2025-03-04  884  	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
bf06eab7ae0f04 steven chen 2025-03-04  885  	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
bf06eab7ae0f04 steven chen 2025-03-04  886  	if (!src_pages) {
bf06eab7ae0f04 steven chen 2025-03-04  887  		pr_err("Could not allocate ima pages array.\n");
bf06eab7ae0f04 steven chen 2025-03-04  888  		return NULL;
bf06eab7ae0f04 steven chen 2025-03-04  889  	}
bf06eab7ae0f04 steven chen 2025-03-04  890  
bf06eab7ae0f04 steven chen 2025-03-04  891  	i = 0;
bf06eab7ae0f04 steven chen 2025-03-04  892  	for_each_kimage_entry(image, ptr, entry) {
bf06eab7ae0f04 steven chen 2025-03-04  893  		if (entry & IND_DESTINATION) {
bf06eab7ae0f04 steven chen 2025-03-04  894  			dest_page_addr = entry & PAGE_MASK;

Is the first entry always IND_DESTINATION?

bf06eab7ae0f04 steven chen 2025-03-04  895  		} else if (entry & IND_SOURCE) {
bf06eab7ae0f04 steven chen 2025-03-04 @896  			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
                                                                    ^^^^^^^^^^^^^^
otherwise this is uninitialized

bf06eab7ae0f04 steven chen 2025-03-04  897  				src_page_addr = entry & PAGE_MASK;
bf06eab7ae0f04 steven chen 2025-03-04  898  				src_pages[i++] =
bf06eab7ae0f04 steven chen 2025-03-04  899  					virt_to_page(__va(src_page_addr));
bf06eab7ae0f04 steven chen 2025-03-04  900  				if (i == npages)
bf06eab7ae0f04 steven chen 2025-03-04  901  					break;
bf06eab7ae0f04 steven chen 2025-03-04  902  				dest_page_addr += PAGE_SIZE;
bf06eab7ae0f04 steven chen 2025-03-04  903  			}
bf06eab7ae0f04 steven chen 2025-03-04  904  		}
bf06eab7ae0f04 steven chen 2025-03-04  905  	}
bf06eab7ae0f04 steven chen 2025-03-04  906  
bf06eab7ae0f04 steven chen 2025-03-04  907  	/* Sanity check. */
bf06eab7ae0f04 steven chen 2025-03-04  908  	WARN_ON(i < npages);
bf06eab7ae0f04 steven chen 2025-03-04  909  
bf06eab7ae0f04 steven chen 2025-03-04  910  	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
bf06eab7ae0f04 steven chen 2025-03-04  911  	kfree(src_pages);
bf06eab7ae0f04 steven chen 2025-03-04  912  
bf06eab7ae0f04 steven chen 2025-03-04  913  	if (!vaddr)
bf06eab7ae0f04 steven chen 2025-03-04  914  		pr_err("Could not map ima buffer.\n");
bf06eab7ae0f04 steven chen 2025-03-04  915  
bf06eab7ae0f04 steven chen 2025-03-04  916  	return vaddr;
bf06eab7ae0f04 steven chen 2025-03-04  917  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


