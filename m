Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C2C4BC75
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2019 17:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbfFSPHd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jun 2019 11:07:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729908AbfFSPHc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jun 2019 11:07:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JF5IHx139886
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 11:07:32 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t7mr5hmnj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 11:07:21 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 19 Jun 2019 16:07:16 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Jun 2019 16:07:14 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5JF7D6960686448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 15:07:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59A4711C050;
        Wed, 19 Jun 2019 15:07:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA04111C04C;
        Wed, 19 Jun 2019 15:07:12 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jun 2019 15:07:12 +0000 (GMT)
Subject: Re: [PATCH v5 06/11] ima-evm-utils: Start converting find_keyid to
 use EVP_PKEY API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
In-Reply-To: <20190618135623.6861-7-vt@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
         <20190618135623.6861-7-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Jun 2019 08:26:30 -0400
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061915-0016-0000-0000-0000028A822C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061915-0017-0000-0000-000032E7D9E8
Message-Id: <1560947190.3975.23.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190122
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-06-18 at 16:56 +0300, Vitaly Chikunov wrote:
> New find_keyid_pkey() accepts EVP_PKEY. Old find_keyid() calls
> find_keyid_pkey(), but still return RSA key.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

With titles starting with "Start converting", it leaves me wondering
whether these patches are bisect safe.  Does this patch make
find_keyid() a wrapper for find_keyid_pkey()?  Do all callers of
find_keyid() continue to work properly?  If so, why are there other
changes in this patch?

If you haven't already, please make sure that after each patch is
applied, the code not only compiles cleanly, but works properly.

Mimi

> ---
>  src/libimaevm.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 707b2e9..ae18005 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -452,11 +452,11 @@ struct public_key_entry {
>  	struct public_key_entry *next;
>  	uint32_t keyid;
>  	char name[9];
> -	RSA *key;
> +	EVP_PKEY *key;
>  };
>  static struct public_key_entry *public_keys = NULL;
> 
> -static RSA *find_keyid(uint32_t keyid)
> +static EVP_PKEY *find_keyid_pkey(uint32_t keyid)
>  {
>  	struct public_key_entry *entry;
> 
> @@ -467,6 +467,22 @@ static RSA *find_keyid(uint32_t keyid)
>  	return NULL;
>  }
> 
> +static RSA *find_keyid(uint32_t keyid)
> +{
> +	EVP_PKEY *pkey;
> +	RSA *key;
> +
> +	pkey = find_keyid_pkey(keyid);
> +	if (!pkey)
> +		return NULL;
> +	key = EVP_PKEY_get0_RSA(pkey);
> +	if (!key) {
> +		log_err("find_keyid: unsupported key type\n");
> +		return NULL;
> +	}
> +	return key;
> +}
> +
>  void init_public_keys(const char *keyfiles)
>  {
>  	struct public_key_entry *entry;
> @@ -489,13 +505,13 @@ void init_public_keys(const char *keyfiles)
>  			break;
>  		}
> 
> -		entry->key = read_pub_key(keyfile, 1);
> +		entry->key = read_pub_pkey(keyfile, 1);
>  		if (!entry->key) {
>  			free(entry);
>  			continue;
>  		}
> 
> -		calc_keyid_v2(&entry->keyid, entry->name, entry->key);
> +		calc_pkeyid_v2(&entry->keyid, entry->name, entry->key);
>  		sprintf(entry->name, "%x", __be32_to_cpup(&entry->keyid));
>  		log_info("key %d: %s %s\n", i++, entry->name, keyfile);
>  		entry->next = public_keys;

