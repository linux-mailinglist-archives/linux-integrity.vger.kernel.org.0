Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644FC69B25
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfGOTJm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 15:09:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfGOTJm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 15:09:42 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FJ6lQF146378
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jul 2019 15:09:41 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2trw8ke1x0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jul 2019 15:09:41 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 15 Jul 2019 20:09:39 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Jul 2019 20:09:36 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6FJ9ZF247644856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 19:09:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 290AAA4051;
        Mon, 15 Jul 2019 19:09:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82E7AA4055;
        Mon, 15 Jul 2019 19:09:34 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Jul 2019 19:09:34 +0000 (GMT)
Subject: Re: [PATCH v1 4/5] ima-evm-utils: Fix file2bin stat and fopen
 relations
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 15 Jul 2019 15:09:34 -0400
In-Reply-To: <20190712212833.29280-4-vt@altlinux.org>
References: <20190712212833.29280-1-vt@altlinux.org>
         <20190712212833.29280-4-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19071519-0008-0000-0000-000002FD7429
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071519-0009-0000-0000-0000226AE798
Message-Id: <1563217774.4539.146.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=851 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150218
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-07-13 at 00:28 +0300, Vitaly Chikunov wrote:

<snip>

> @@ -186,18 +187,32 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
> 
>  	log_info("Reading to %s\n", name);
> 
> -	len = get_filesize(name);
>  	fp = fopen(name, "r");
>  	if (!fp) {
>  		log_err("Failed to open: %s\n", name);
>  		return NULL;
>  	}
> +	if (fstat(fileno(fp), &stats) == -1) {
> +		log_err("Failed to fstat: %s (%s)\n", name, strerror(errno));
> +		fclose(fp);
> +		return NULL;
> +	}
> +	len = stats.st_size;
> +
>  	data = malloc(len);
> -	if (!fread(data, len, 1, fp))
> -		len = 0;
> +	if (!data) {
> +		log_err("Failed to malloc %zu bytes: %s\n", len, name);

Missing "free(data)"

> +		fclose(fp);
> +		return NULL;
> +	}
> +	if (fread(data, len, 1, fp) != len) {
> +		log_err("Failed to fread %zu bytes: %s\n", len, name);
> +		fclose(fp);

and here
> +		return NULL;
> +	}
>  	fclose(fp);
> 
> -	*size = len;
> +	*size = (int)len;
>  	return data;
>  }
> 

