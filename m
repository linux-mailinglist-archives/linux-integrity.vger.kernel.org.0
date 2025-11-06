Return-Path: <linux-integrity+bounces-7590-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75689C3B6B2
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 14:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A111A41FB0
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDA333A02B;
	Thu,  6 Nov 2025 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/TXaHEt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tUVQ5P4F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4433A011
	for <linux-integrity@vger.kernel.org>; Thu,  6 Nov 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436418; cv=none; b=rzELsA75W2ue6MSyBlP/5W4466D9c3IjVO/gpk6Y+F+X2OK1OUSbglwpegr1WnKKpz9LGjk7o8ZimDkdyBn6/uLGFHlrw+uQV8pmxOwlBO3FEyCfl/dQUjCBEqje2edyXX5tc93n7ukdkRSBQHHDY+/VZ4AEKtBau6J0UMsbjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436418; c=relaxed/simple;
	bh=uUlzz1SanQRYx/DFcY6UUxeg99XLdI7AB5xH58h796U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1d5Dk88UURWjMRPRBLOb2BXHeJkmtWuMibuA5W/aq7CeNrHu/cARFrCXq4Q2RC0y8EzWwcoO0NZHlqJxiPTv82yNG/V8G+oBBO/ERqiEakrE5+08pz5w7ceL4GHuGaeWAk3j7ZGrbxOTrAwa1mELA6glk57nAjY3v/QVmLBP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/TXaHEt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tUVQ5P4F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762436415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkz72yTbvJHMytWdiLGhiha3HbVo2IXnZtXQ3EROj+0=;
	b=R/TXaHEt2Zy+fXkU553Fi2Z/nkQR1QqJUAxC/wQj5KpK1i0RYdP9bezbMopPFsSIhmcZwx
	L+MZ2Ub7lypbIe8zAsYF12T2TNbaU0hvGOd2jJEKr0ppjs0Dx8SQlXTI8J5U3RsJd+w4g7
	qALkoIaE2bV19w6fipm0LTs4zQ6upfI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-Mqsdb-CKOF6BAfRVRVswwA-1; Thu, 06 Nov 2025 08:40:14 -0500
X-MC-Unique: Mqsdb-CKOF6BAfRVRVswwA-1
X-Mimecast-MFC-AGG-ID: Mqsdb-CKOF6BAfRVRVswwA_1762436413
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295952a4dd6so30743665ad.1
        for <linux-integrity@vger.kernel.org>; Thu, 06 Nov 2025 05:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762436413; x=1763041213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qkz72yTbvJHMytWdiLGhiha3HbVo2IXnZtXQ3EROj+0=;
        b=tUVQ5P4Ff5WuxoLkV60mfrV/tMsAsGbkd0sCpEGj7EuP0nO99fSQthh04oiODOaNHO
         hQvSaR962bxEHU6obdCPahESy8wz2pndtrh3yoHcL3DySfxx560GOoxF3BREJjfVpELR
         Zj2PJNDWa5RmaLEPrSjGpAlbCY4E1GE/0CxUZ9Z74iY8rf9rXtmN0PMqGImyOJqZ7x/I
         WEyBpOkYizn0DXc5uaXyMb/rAtJNxWbfF9qFGBBjNEj7p64ZEf4NKcaXujwLXCuozvAB
         8KysqlDvrDz4LOdKkieycI46egnMO0BSXdVLmm4ccdW7vELwYCzylRfT3PNEfgr2q5tM
         jUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762436413; x=1763041213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkz72yTbvJHMytWdiLGhiha3HbVo2IXnZtXQ3EROj+0=;
        b=J5eJWmtHpoyF3kUIiJB35URyv6PTs7oj/Cak4aaVfX/r1i0ob5YwiLUMpOfCUH+DZj
         PHzhFB1FRkaW4bx0uSrfjUjtcbd3kvCQIzX+79WHV7bzsMTv0OdrTp0ZIkgGXITufq95
         iPRkr73ct7F/QhpEMQj6TneNDOKBpRF7Am2B7iL65M5upX0xkQQrrRyGov83X2W7bW5U
         BPt94GJ2aCdN30Oj4894VluHrkfzsFIO8diNeN+ZEu5qsmNvLYOhQ4BGtHmb663+dEkl
         y4c+EoNDb4Px4GG72rSuBN6C6Z9C18bvfmPFm5jaQ/xUACqAWAlS9bXqrNOZcf+xnsyu
         xQew==
X-Gm-Message-State: AOJu0YybYEtcSdLhYu9jINApcKKHsBAmfYJGncSApfIWtNNAuzNUwuPz
	QCyLke1NUTnNt3Y2E0NHTPqFH5ri6yn7BPyAE+kBAUNVUpI6p38hHodj32RV2WQrdXkH9tTErM4
	l/XCmeJLlbWiTggtFKvnEcuTPKJdHno7jE5dg9MiNzRlMgDMy+bNEVYUpoBEinsS/D0sSjA==
X-Gm-Gg: ASbGnctToRS2Gn+30lRRxKaqmwlKanV5d5eWwFZNKWgR4nsEZncTEgEQrNHlVJj5aDs
	Z/kNyoMcv439QQbPg6CVbk8va+C5IhttIt4AvP2CRm3yIeS3pBbGbi0aZGzA5+j+io3fKJ2O7z3
	X0bcgSGtRyZsdeWYDQ2o+eW4mUklp4TQ2rxs20DQGnJpg6OeTO8zwiPvg9w9+6y3T48toz6fZ0i
	Bo7CSnO3NBC46G+fhqyPirhXmTbU56azgVxlooBHd6dn2Ke7o077QYEvcAwH1VHk32bvjvuI7AN
	UFqo69nuCZ8Bp7u4SDVpkh4Y4GN+TktxWzt0bm3qDnv7IgiyoIVKBIYljV2E+la0PQ==
X-Received: by 2002:a05:6a21:998f:b0:33d:7c17:deb4 with SMTP id adf61e73a8af0-350de60ef4dmr4511320637.18.1762436412853;
        Thu, 06 Nov 2025 05:40:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpqJ2Tqnwq4JekdzegbtzxvbqJx+H0dECy9gVADvuDqgqPrgvVh+iyG7BrVNpmORyKNnpgRQ==
X-Received: by 2002:a05:6a21:998f:b0:33d:7c17:deb4 with SMTP id adf61e73a8af0-350de60ef4dmr4511262637.18.1762436412235;
        Thu, 06 Nov 2025 05:40:12 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7f7565bbsm2913270b3a.9.2025.11.06.05.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:40:11 -0800 (PST)
Date: Thu, 6 Nov 2025 21:35:08 +0800
From: Coiby Xu <coxu@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Srot <ksrot@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
Message-ID: <h4eloauedfln56moljqb724wsiqyhk4gsggexx3tsn4o4utjeu@ieczfooqcqsf>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <20251031074016.1975356-1-coxu@redhat.com>
 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
 <CAHC9VhRGwXvhU64Nk5jdmtPfrt9bbkzpLVqS0LRbtN3Q3HhnCw@mail.gmail.com>
 <0c7e94a436a3742003e5e1155a48480d8307a9c7.camel@linux.ibm.com>
 <CAHC9VhS6xWvu5TjjS4MRGFEWxdAhg-Xsf6L+=K0k8U+fgiAtTQ@mail.gmail.com>
 <8646ad03f2f14f45c0ade7c7d7cc148f56d964b1.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8646ad03f2f14f45c0ade7c7d7cc148f56d964b1.camel@linux.ibm.com>

On Wed, Nov 05, 2025 at 03:25:05PM -0500, Mimi Zohar wrote:
>On Wed, 2025-11-05 at 10:42 -0500, Paul Moore wrote:
>> On Wed, Nov 5, 2025 at 9:07 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>> > On Tue, 2025-11-04 at 21:47 -0500, Paul Moore wrote:
>> > > Assuming I'm understanding the problem correctly, I think you're
>> > > making this harder than it needs to be.  I believe something like this
>> > > should solve the problem without having to add more conditionals
>> > > around the hooks in kernel_read_file(), and limiting the multiple
>> > > security_kernel_post_read_file() calls to just the compressed case ...
>> > > and honestly in each of the _post_read_file() calls in the compressed
>> > > case, the buffer contents have changed so it somewhat makes sense.
>> >
>> > > Given the code below, IMA could simply ignore the
>> > > READING_MODULE_COMPRESSED case (or whatever it is the IMA needs to do
>> > > in that case) and focus on the READING_MODULE case as it does today.
>> > > I expect the associated IMA patch would be both trivial and small.
>> > >
>> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
>> > > index c66b26184936..b435c498ec01 100644
>> > > --- a/kernel/module/main.c
>> > > +++ b/kernel/module/main.c
>> > > @@ -3675,17 +3675,19 @@ static int idempotent_wait_for_completion(struct idempot
>> > > ent *u)
>> > >
>> > > static int init_module_from_file(struct file *f, const char __user * uargs, int
>> > > flags)
>> > > {
>> > > +       bool compressed = !!(flags & MODULE_INIT_COMPRESSED_FILE);
>> > >        struct load_info info = { };
>> > >        void *buf = NULL;
>> > >        int len;
>> > >
>> > > -       len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
>> > > +       len = kernel_read_file(f, 0, &buf, INT_MAX, NULL,
>> > > +                              compressed ? READING_MODULE_COMPRESSED : READING_
>> > > MODULE);
>> > >        if (len < 0) {
>> > >                mod_stat_inc(&failed_kreads);
>> > >                return len;
>> > >        }
>> > >
>> > > -       if (flags & MODULE_INIT_COMPRESSED_FILE) {
>> > > +       if (compressed) {
>> > >                int err = module_decompress(&info, buf, len);
>> > >                vfree(buf); /* compressed data is no longer needed */
>> > >                if (err) {
>> > > @@ -3693,6 +3695,14 @@ static int init_module_from_file(struct file *f, const ch
>> > > ar __user * uargs, int
>> > >                        mod_stat_add_long(len, &invalid_decompress_bytes);
>> > >                        return err;
>> > >                }
>> > > +
>> > > +               err = security_kernel_post_read_file(f,
>> > > +                                                    (char *)info.hdr, info.len,
>> > > +                                                    READING_MODULE);
>> >
>> > Without changing the enumeration here, IMA would not be able to differentiate
>> > the first call to security_kernel_post_read_file() and this one.  The first call
>> > would result in unnecessary error messages.
>>
>> Given the patch snippet above, in the case where an uncompressed
>> module is passed into init_module_from_file() there would be the
>> following checks, in this order:
>>
>>  * kernel_read_file()
>>  -> security_kernel_read_file(READING_MODULE)
>>  -> security_kernel_post_read_file(READING_MODULE)
>>  * init_module_from_file()
>>  -> NONE
>>
>> ... this should be the same as the current behavior.
>>
>> In the case where a compressed module is passed into
>> init_module_from_file() there would be the following checks, in this
>> order:
>>
>>  * kernel_read_file()
>>  -> security_kernel_read_file(READING_MODULE_COMPRESSED)
>>  -> security_kernel_post_read_file(READING_MODULE_COMPRESSED)
>>  * init_module_from_file()
>>  -> security_kernel_post_read_file(READING_MODULE)
>>
>> ... the two differences being that the hook calls in
>> kernel_read_file() use the READING_MODULE_COMPRESSED id, which seems
>> appropriate as the data passed to the hook is the compressed
>> representation, and the additional _post_read_file() hook call in
>> init_module_from_file() using the READING_MODULE id, as the data
>> passed to the hook is now uncompressed.  Not only should IMA be able
>> to easily differentiate between the two _post_read_file() calls, but
>> it should have access to both the compressed and uncompressed data.
>
>Thanks, Paul.  Yes, a single additional enumeration is enough.

Yeah, thank Paul for elaborating on the solution!

>
>Mimi
>

-- 
Best regards,
Coiby


