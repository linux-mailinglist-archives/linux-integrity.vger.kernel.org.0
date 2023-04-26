Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6996EF5E6
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Apr 2023 15:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbjDZN64 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Apr 2023 09:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbjDZN6y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Apr 2023 09:58:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150CF6598
        for <linux-integrity@vger.kernel.org>; Wed, 26 Apr 2023 06:58:53 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QDlGGt027495;
        Wed, 26 Apr 2023 13:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=wrRP0JGY1IsXcRGL8X1HHCwRotmCB9tZP6sT29ANv74=;
 b=Cs6sLxYI1awLrPwMuGoJO/94xBMdmb/ap4T5Bui6E82yEde9qSZGuWIdN6Sdu4CDk2Me
 IEa0R1oCm3rtIkiOSKr5gcOGUGohRBB+wczOKM8nqWBFKpQrNhWyvWKb5UTW3zA0chxG
 e3lWoo6sTVN4n+OaD67O6HBsJ/agNgaOaOWKcztrh5x9V7HoBeObU4Z9r6tmA0OETO2S
 illIoZVcCjgp4O1/ho3O7dDjciwjpUogK2eVrdEjUc2twhu5o6uROkugFcyrZ2rBixVF
 vjC1a/GMVsq5LMqJHmks8S52tKKrKsWJQM1OPCcGoVfGQc1caIV/p7aoL6/DAm2u7eLc dQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q73gem7dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 13:58:51 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33QCT6Of013008;
        Wed, 26 Apr 2023 13:58:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3q47785mxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 13:58:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33QDwmOG19202322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 13:58:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6210D58061;
        Wed, 26 Apr 2023 13:58:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2134758058;
        Wed, 26 Apr 2023 13:58:48 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.78.196])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Apr 2023 13:58:48 +0000 (GMT)
Message-ID: <19fb6105c7343810a879a52421d847ab665bd8e9.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2 2/2] examples: Add examples for
 elliptic curve key and certs generation
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Eric Snowberg <eric.snowberg@oracle.com>
Date:   Wed, 26 Apr 2023 09:58:47 -0400
In-Reply-To: <20230425161015.593988-3-stefanb@linux.ibm.com>
References: <20230425161015.593988-1-stefanb@linux.ibm.com>
         <20230425161015.593988-3-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9uauzzMbNPAK8nSx7CPC5PsG5Xa1NYDz
X-Proofpoint-ORIG-GUID: 9uauzzMbNPAK8nSx7CPC5PsG5Xa1NYDz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_06,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304260121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

hHi Stefan,

On Tue, 2023-04-25 at 12:10 -0400, Stefan Berger wrote:
> Add example scripts for ECC key and certificate creation and reference
> them from the README.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thank you for adding the ECC examples.  With Eric Snowberg's "Add CA
enforcement keyring restrictions" patch (Linux v6.4) and the proposed
IMA changes, the existing scripts in the examples/ directory need to be
updated.   Before upstreaming these ECC scripts, let's at least update
them.

From Jarkko's v6.4 pull request

The .machine keyring, used for Machine Owner Keys (MOK), acquired the
ability to store only CA enforced keys, and put rest to the .platform
keyring, thus separating the code signing keys from the keys that are
used to sign certificates. This essentially unlocks the use of the
.machine keyring as a trust anchor for IMA. It is an opt-in feature,
meaning that the additional contraints won't brick anyone who does not
care about them.

> ---
>  README                           |  3 +++
>  examples/ima-gen-local-ca-ecc.sh | 29 ++++++++++++++++++++++++++++
>  examples/ima-genkey-ecc.sh       | 33 ++++++++++++++++++++++++++++++++
>  examples/ima-genkey-self-ecc.sh  | 29 ++++++++++++++++++++++++++++
>  4 files changed, 94 insertions(+)
>  create mode 100755 examples/ima-gen-local-ca-ecc.sh
>  create mode 100755 examples/ima-genkey-ecc.sh
>  create mode 100755 examples/ima-genkey-self-ecc.sh
> 
> diff --git a/README b/README
> index fd12680..ef7f475 100644
> --- a/README
> +++ b/README
> @@ -469,6 +469,9 @@ Examples of scripts to generate X509 public key certificates:
>   /usr/share/doc/ima-evm-utils/ima-genkey-self.sh
>   /usr/share/doc/ima-evm-utils/ima-genkey.sh
>   /usr/share/doc/ima-evm-utils/ima-gen-local-ca.sh
> + /usr/share/doc/ima-evm-utils/ima-genkey-self-ecc.sh
> + /usr/share/doc/ima-evm-utils/ima-genkey-ecc.sh
> + /usr/share/doc/ima-evm-utils/ima-gen-local-ca-ecc.sh
>  
>  
>  AUTHOR
> diff --git a/examples/ima-gen-local-ca-ecc.sh b/examples/ima-gen-local-ca-ecc.sh
> new file mode 100755
> index 0000000..ee2aeb6
> --- /dev/null
> +++ b/examples/ima-gen-local-ca-ecc.sh
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +
> +GENKEY=ima-local-ca.genkey
> +
> +cat << __EOF__ >$GENKEY
> +[ req ]
> +distinguished_name = req_distinguished_name
> +prompt = no
> +string_mask = utf8only
> +x509_extensions = v3_ca
> +
> +[ req_distinguished_name ]
> +O = IMA-CA
> +CN = IMA/EVM certificate signing key
> +emailAddress = ca@ima-ca
> +
> +[ v3_ca ]
> +basicConstraints=CA:TRUE
> +subjectKeyIdentifier=hash
> +authorityKeyIdentifier=keyid:always,issuer
> +# keyUsage = cRLSign, keyCertSign

With the INTEGRITY_CA_MACHINE_KEYRING_MAX Kconfig, keyCertSign is
required for loading keys onto the .machine keyring.  Please uncomment
the above line.


> +__EOF
> +
> +openssl req -new -x509 -utf8 -sha1 -days 3650 -batch -config $GENKEY \

Please update sha1 to sha256.


> +		-outform DER -out ima-local-ca.x509 -keyout ima-local-ca.priv \
> +		-newkey ec -pkeyopt ec_paramgen_curve:prime256v1
> +
> +openssl x509 -inform DER -in ima-local-ca.x509 -out ima-local-ca.pem
> +
> diff --git a/examples/ima-genkey-ecc.sh b/examples/ima-genkey-ecc.sh
> new file mode 100755
> index 0000000..735c665
> --- /dev/null
> +++ b/examples/ima-genkey-ecc.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +GENKEY=ima.genkey
> +
> +cat << __EOF__ >$GENKEY
> +[ req ]
> +distinguished_name = req_distinguished_name
> +prompt = no
> +string_mask = utf8only
> +x509_extensions = v3_usr
> +
> +[ req_distinguished_name ]
> +O = `hostname`
> +CN = `whoami` signing key
> +emailAddress = `whoami`@`hostname`
> +
> +[ v3_usr ]
> +basicConstraints=critical,CA:FALSE
> +#basicConstraints=CA:FALSE
> +keyUsage=digitalSignature
> +#keyUsage = nonRepudiation, digitalSignature, keyEncipherment

In preparation to allowing only code signing keys on the IMA keyring,
please add "extendedKeyUsage=critical,codeSigning",

> +subjectKeyIdentifier=hash
> +authorityKeyIdentifier=keyid
> +#authorityKeyIdentifier=keyid,issuer
> +__EOF__
> +
> +openssl req -new -nodes -utf8 -sha1 -days 365 -batch -config $GENKEY \

And similarly change sha1 to sha256 here.

> +		-out csr_ima.pem -keyout privkey_ima.pem \
> +		-newkey ec -pkeyopt ec_paramgen_curve:prime256v1
> +openssl x509 -req -in csr_ima.pem -days 365 -extfile $GENKEY -extensions v3_usr \
> +		-CA ima-local-ca.pem -CAkey ima-local-ca.priv -CAcreateserial \
> +		-outform DER -out x509_ima.der
> +

-- 
thanks,

Mimi

