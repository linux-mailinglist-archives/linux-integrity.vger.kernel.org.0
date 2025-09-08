Return-Path: <linux-integrity+bounces-7031-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 694A1B48BF4
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 13:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A343C2A50
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 11:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8765E220F3F;
	Mon,  8 Sep 2025 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgjOyCn7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8822759C
	for <linux-integrity@vger.kernel.org>; Mon,  8 Sep 2025 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330120; cv=none; b=tDoSUjGb0dPHPCPBUNkdlRcMks/xp9pKmy2ce02iI9r8AzDtGHmY2r6Ln+LHBswy9eUiBJTeL4d1QsWG2tdCAXeYvth8+YYXmuQxPQVxZFrKOS+b6KTjAs8FEAPHI0e1hyRFMLrDJrfPNG52Q5kJebq5KOcHVMNULCPgULXKtMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330120; c=relaxed/simple;
	bh=aUVE8FthtNrnN/ESZ4IO98xDT5XV5Larg3g6OfQcICU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qi1LUMYjfj7YVAWuniogha3+FE3JsgaoQcXmJHDoFJPCep0UEEBNmBIL+AlNzY7iaymC7FiUcrQgz4jdAQdG9sNx0U5Bvzv5GWlCnJJ3R4FeDcUkcoaOxJcsK/DPv1SjnqO+At6O4vF0ytIckffbZP3/4b2dZgeWpEsaPMTCZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgjOyCn7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757330117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wwUZv7xn5kwJDxXIChe0wNGvkZwPHl5q6JPSLW8gUe4=;
	b=SgjOyCn7pFBImS+kMEsXxoCCZoW2nSLswWXikrpQW9oxL00O6DxTyLrpEdmuUjgLWplH1Z
	kcfSDxDx4DyPmz3aCBGt2G/spUVw9fij3QKJaFn1geuKWly6uazddROGpSNEvX3enHcE/o
	enKHc8YlpwKuL3BjmNRqu/578gd4q04=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-B4DCTnNZO6-mlGlNid2ucA-1; Mon, 08 Sep 2025 07:15:15 -0400
X-MC-Unique: B4DCTnNZO6-mlGlNid2ucA-1
X-Mimecast-MFC-AGG-ID: B4DCTnNZO6-mlGlNid2ucA_1757330115
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so9264240b3a.0
        for <linux-integrity@vger.kernel.org>; Mon, 08 Sep 2025 04:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757330115; x=1757934915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwUZv7xn5kwJDxXIChe0wNGvkZwPHl5q6JPSLW8gUe4=;
        b=gz4cDhabTEnEotgmiFS5BGzLzewjhQgQJwjv0fZfGX/sMQ2yAavKrDV1NUrLy1l6+B
         PHsaR8Cx0XbASHa9am0z8qWsuFLXqMyulNVdUwgjlxBKoujVOXLKn1JpZC3W8qNty0/F
         iEJUE91TYjkLSiavvLquGBuIuYjEgcToug3VC5Fhdc3I5ReooaCcF7tlinD77aNdmGri
         jKwhkYL95lSqT/lMLPZ5YArVckdhSlpRFJcug2XQva8dmxdMjZoSOgE+2akLj/Es74VG
         7guhZtDcD9fVkn6L1evhm6GdmHQmE7V0bUi6z/JHD4t6u3XTUaF23QmeM6FU0ItVOg5o
         aVkg==
X-Gm-Message-State: AOJu0Yx9zlQfL9MEps/Eo1918KrN/al9cLLiXRn/PIOlPfpLulUf+weF
	iE8azMWl/MtDg/aAgw196MUwvY51IGngUMX5oORNZGJG/GtCL7oAqNC0cIwdVgz7vTm+baPUh1p
	ogUEh5nzJqz/2KZgOSKmwplI8EUmzZKVmEGQ87CJ0hMb5wXqLfPloiIvLD306FQpRdzSisA==
X-Gm-Gg: ASbGncszrLD8Z37Pyh8gTzd6TUt6vTutlWq6SQbuRp9UPl51TXsKz2pkE2PtFkdwM91
	qvWQz0ZM2uV+tg8gp+OmN78Yq6qWiX70jNmP8IQHwzMXTduvQro4z7bYh20VmGWC12Gl0uBLwiW
	KNZsWJYoVkSNFAr52mcExkcVuR8fTCmLIkzExxbdYfcynk0gsDkeD0yTpuoj0CqTmwrkd/4V96w
	YJV1PdS1o84AMvBQy4l5/K/Sw4a2n0+tU6phVRj+ccR1RPg0Ul5TxWpGBYdRDqJXqGf/vbJdnnJ
	gvh22Dk9EYH0gBMON4ANherb27ILutk=
X-Received: by 2002:a05:6a00:4613:b0:772:5b74:c26e with SMTP id d2e1a72fcca58-7742dea660amr11162783b3a.18.1757330114620;
        Mon, 08 Sep 2025 04:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1AQ3ExSzLUZMdMo+aC42rYKm4I5V31Fv7OTUPdi28epWE4qludHltIl7qqNhPZKbMu+fugA==
X-Received: by 2002:a05:6a00:4613:b0:772:5b74:c26e with SMTP id d2e1a72fcca58-7742dea660amr11162739b3a.18.1757330114113;
        Mon, 08 Sep 2025 04:15:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1ca7sm29403639b3a.71.2025.09.08.04.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 04:15:13 -0700 (PDT)
Date: Mon, 8 Sep 2025 19:12:07 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
Message-ID: <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
References: <20250902042515.759750-1-coxu@redhat.com>
 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>

On Thu, Sep 04, 2025 at 10:41:42PM -0400, Mimi Zohar wrote:
>On Tue, 2025-09-02 at 12:25 +0800, Coiby Xu wrote:
>> Currently when both IMA and EVM are in fix mode, the IMA signature will
>> be reset to IMA hash if a program first stores IMA signature in
>> security.ima and then sets security.selinux for a file. For example, on
>> Fedora, after booting the kernel with "ima_appraise=fix evm=fix
>> ima_policy=appraise_tcb" and installing rpm-plugin-ima, reinstalling a
>> package will not make good reference IMA signature generated. Instead
>> IMA hash is generated,
>>     # getfattr -m - -d -e hex /usr/bin/bash
>>     # file: usr/bin/bash
>>     security.ima=0x0404...
>>
>> This happens because when setting selinux.selinux, the IMA_DIGSIG flag
>> that had been set early was cleared. As a result, IMA hash is generated
>> when the file is closed.
>>
>> Here's a minimal C reproducer,
>>
>>     #include <stdio.h>
>>     #include <sys/xattr.h>
>>     #include <fcntl.h>
>>     #include <unistd.h>
>>     #include <string.h>
>>     #include <stdlib.h>
>>
>>     int main() {
>>         const char* file_path = "/usr/sbin/test_binary";
>>         const char* hex_string = "030204d33204490066306402304";
>>         int length = strlen(hex_string);
>>         char* ima_attr_value;
>>         int fd;
>>
>>         fd = open(file_path, O_WRONLY|O_CREAT|O_EXCL, 0644);
>>         if (fd == -1) {
>>             perror("Error opening file");
>>             return 1;
>>         }
>>
>>         ima_attr_value = (char*)malloc(length / 2 );
>>         for (int i = 0, j = 0; i < length; i += 2, j++) {
>>             sscanf(hex_string + i, "%2hhx", &ima_attr_value[j]);
>>         }
>>
>>         if (fsetxattr(fd, "security.ima", ima_attr_value, length/2, 0) == -1) {
>>             perror("Error setting extended attribute");
>>             close(fd);
>>             return 1;
>>         }
>>
>>         const char* selinux_value= "system_u:object_r:bin_t:s0";
>>         if (fsetxattr(fd, "security.selinux", selinux_value, strlen(selinux_value), 0) == -1) {
>>             perror("Error setting extended attribute");
>>             close(fd);
>>             return 1;
>>         }
>>
>>         close(fd);
>>
>>         return 0;
>>     }
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Thanks, Coiby.  Agreed, the ability to clear the IMA_DIGSIG flag should be
>limited to security.ima xattr and probably security.evm xattr.  Writing other
>security xattrs should not affect the IMA_DIGSIG flag.

Thanks for confirming it!

>
>Even without an IMA appraise policy, the security xattrs are written out to the
>filesystem, but the IMA_DIGSIG flag is not cached.

It seems I miss some context for the above sentence. If no IMA policy is
configured, no ima_iint_cache will be created. If you mean non-appraisal
policy, will not caching IMA_DIGSIG flag cause any problem?

>
>Please document the tristate values:
>0: clear IMA_DIGSIG
>1: set IMA_DIGSIG
>-1: don't change IMA_DIGSIG

Addressed in v2. Thanks for the suggestion!

>
>> ---
>>  security/integrity/ima/ima_appraise.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> index f435eff4667f..fc82161f8b30 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -708,7 +708,7 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>>  	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
>>  	if (digsig)
>>  		set_bit(IMA_DIGSIG, &iint->atomic_flags);
>
>This matches both -1 and 1.  Test "digsig == 1" here.
>
>> -	else
>> +	else if (digsig != -1)
>
>and test "digsig == 0" here.
>
>>  		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>>  }
>>
>> @@ -794,6 +794,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>  		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
>>  	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) {
>>  		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
>> +	} else if (result != 1) {
>
>The "if (result != 1)" test is redundant.

I've fixed them in v2. Thanks for reviewing the patch and correcting my
careless mistakes! I'll check if my mind is in a clear thinking state
next time.


>
>thanks,
>
>Mimi
>
>> +		digsig = -1;
>>  	}
>>  	if (result == 1 || evm_revalidate_status(xattr_name)) {
>>  		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
>

-- 
Best regards,
Coiby


