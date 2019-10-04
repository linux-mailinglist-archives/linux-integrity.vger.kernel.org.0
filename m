Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D93CB2BD
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2019 02:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfJDAZb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 20:25:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730956AbfJDAZa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 20:25:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x940Cu29143255;
        Thu, 3 Oct 2019 20:25:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vds99btvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 20:25:22 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x940EEIM146129;
        Thu, 3 Oct 2019 20:25:22 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vds99btvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 20:25:22 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x940BcjA031002;
        Fri, 4 Oct 2019 00:25:21 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 2v9y5a4k4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 00:25:21 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x940PJIs57409950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Oct 2019 00:25:19 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A76116A05A;
        Fri,  4 Oct 2019 00:25:19 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 221E16A04D;
        Fri,  4 Oct 2019 00:25:18 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.174.252])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  4 Oct 2019 00:25:17 +0000 (GMT)
Message-ID: <1570148716.10818.19.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] tpm: Use GFP_KERNEL for allocating struct tpm_buf
From:   James Bottomley <jejb@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 03 Oct 2019 17:25:16 -0700
In-Reply-To: <20191003185103.26347-2-jarkko.sakkinen@linux.intel.com>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
         <20191003185103.26347-2-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910040000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-10-03 at 21:51 +0300, Jarkko Sakkinen wrote:
> Switch from GFP_HIGHUSER to GFP_KERNEL. On 32-bit platforms kmap()
> space
> could be unnecessarily wasted because of using GFP_HIGHUSER by taking
> a
> page of from the highmem.
> 
> Suggested-by: James Bottomley <jejb@linux.ibm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/char/tpm/tpm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index a4f74dd02a35..d20745965350 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -297,7 +297,7 @@ static inline void tpm_buf_reset(struct tpm_buf
> *buf, u16 tag, u32 ordinal)
>  
>  static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32
> ordinal)
>  {
> -	buf->data_page = alloc_page(GFP_HIGHUSER);
> +	buf->data_page = alloc_page(GFP_KERNEL);
>  	if (!buf->data_page)
>  		return -ENOMEM;

The kmap/kunmap needs removing as well, and now the data_page field
isn't necessary, so it can go.  I think the result should be something
like the below (uncompiled and untested).

James

---

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index a7fea3e0ca86..b4f1cbf344b6 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -284,7 +284,6 @@ enum tpm_buf_flags {
 };
 
 struct tpm_buf {
-	struct page *data_page;
 	unsigned int flags;
 	u8 *data;
 };
@@ -300,20 +299,18 @@ static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 
 static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
 {
-	buf->data_page = alloc_page(GFP_HIGHUSER);
-	if (!buf->data_page)
+	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!buf->data)
 		return -ENOMEM;
 
 	buf->flags = 0;
-	buf->data = kmap(buf->data_page);
 	tpm_buf_reset(buf, tag, ordinal);
 	return 0;
 }
 
 static inline void tpm_buf_destroy(struct tpm_buf *buf)
 {
-	kunmap(buf->data_page);
-	__free_page(buf->data_page);
+	free_page(buf->data);
 }
 
 static inline u32 tpm_buf_length(struct tpm_buf *buf)


