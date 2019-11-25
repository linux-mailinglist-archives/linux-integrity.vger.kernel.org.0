Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74C109356
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2019 19:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfKYSOr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Nov 2019 13:14:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727928AbfKYSOq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Nov 2019 13:14:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAPI8Hjl045626
        for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2019 13:14:45 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wfk45efnp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2019 13:14:45 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 25 Nov 2019 18:14:43 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Nov 2019 18:14:39 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAPIEcW933292292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 18:14:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA92E52052;
        Mon, 25 Nov 2019 18:14:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.107])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F01605204E;
        Mon, 25 Nov 2019 18:14:37 +0000 (GMT)
Subject: Re: IMA: Data included in the key measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, dhowells@redhat.com
Cc:     James Morris <jamorris@linuxonhyperv.com>
Date:   Mon, 25 Nov 2019 13:14:37 -0500
In-Reply-To: <6ceecb10-61f5-1067-d219-1f6caaa104a9@linux.microsoft.com>
References: <19242774-688e-58ff-40f8-e346d6ba4339@linux.microsoft.com>
         <1574354333.3277.27.camel@HansenPartnership.com>
         <b4257d08-f6cf-19a0-f6f0-99c962ededac@linux.microsoft.com>
         <1574439451.3331.14.camel@HansenPartnership.com>
         <6ceecb10-61f5-1067-d219-1f6caaa104a9@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19112518-0028-0000-0000-000003BF5D71
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112518-0029-0000-0000-00002482930A
Message-Id: <1574705677.4793.215.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_04:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911250149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-11-25 at 09:33 -0800, Lakshmi Ramasubramanian wrote:
> On 11/22/19 8:17 AM, James Bottomley wrote:
> 
> > If you measure at time of insertion you should be able to measure the
> > entire key because it's inserted as a complete certificate.  If there's
> > additional data you need to retrieve after the load, we might be able
> > to store it in addition to the data we already save from the
> > certificate.
> > 
> > James
> 
> You are right James - at the time of insertion the complete certificate 
> can be measured. Thanks for the information.
> 
> I will update my patch set to include the certificate data in key 
> measurement. Please let me know if you have any comments\concerns.
> 
> Please see below for details:
> 
> In the file "security/keys/key.c" =>
> key_ref_t key_create_or_update(key_ref_t keyring_ref,
> 			       const char *type,
> 			       const char *description,
> 			       const void *payload,
> 			       size_t plen,
> 			       key_perm_t perm,
> 			       unsigned long flags)
> 
> In the key measurement, instead of just the "public key", I included the 
> buffer pointed to by the "payload" parameter (buffer of size "plen" 
> bytes) in the call to key_create_or_update(). It is the entire certificate.
> 
> thanks,
>   -lakshmi
> 
> Please see the sequence of commands below to import a certificate (in 
> DER format) to ".ima" keyring and regenerate the certificate from the 
> IMA measurement log.
> 
> ****** Import a DER certificate to .ima keyring ******
> 
> root@nramas:/home/nramas# keyctl show %:.ima
> Keyring
>    75295183 ---lswrv      0     0  keyring: .ima
> 
> root@nramas:/home/nramas# evmctl import x509_ima.der 75295183
> 118886017
> 
> root@nramas:/home/nramas# keyctl show %:.ima
> Keyring
>    75295183 ---lswrv      0     0  keyring: .ima
>   118886017 --als--v      0     0   \_ asymmetric: hostname: whoami 
> signing key: 052dd247dc3c36d6d60675fe7ae869790be56171
> 
> ****** View the IMA measurement log ******
> 
> root@nramas:/home/nramas# cat 
> /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> 10 faf3dd532114feed8b8215eb7b5d8c3107d5e702 ima-buf 
> sha256:ac8bd67bdaded63be9231c495585fd88edce0812d9b677e1e1e219e2dd3bcd60 
> .ima 
> 30820286308201efa00302010202145be0234ff3adf050349b33b89465a6aab6e339f7300d06092a864886f70d01010b050030503111300f060355040a0c08686f73746e616d65311b301906035504030c1277686f616d69207369676e696e67206b6579311e301c06092a864886f70d010901160f77686f616d6940686f73746e616d65301e170d3139303832323032323930325a170d3230303832313032323930325a30503111300f060355040a0c08686f73746e616d65311b301906035504030c1277686f616d69207369676e696e67206b6579311e301c06092a864886f70d010901160f77686f616d6940686f73746e616d6530819f300d06092a864886f70d010101050003818d0030818902818100ee96b264072a42888f78a2f9b8198467a3ad97d126f3d1cc1c24d23e7185cc743b04d4a54254ca16e1e11ed4450deb98b1f7bb4288424570fabcfc6d5aa93a2a14fa2b7835ac877cfea761e5ff414c6ee274eff26f8bd6c484312e56619299acf0dbd224b87c3883b66a9393d21af8962458663b0ac1706c63773cd50e8236270203010001a35d305b300c0603551d130101ff04023000300b0603551d0f040403020780301d0603551d0e04160414052dd247dc3c36d6d60675fe7ae869790be56171301f0603551d23041830168014e36710f0834c973ed94a186fbcd22375b45e2454300d06092a864886f70d01010b050003818100b12faeff1e0e390cfd5eb7140af3b7a653cb49c6ab0a23be24c035331d7600c8f758f9df7fdfc5eeb6fec35859203eca0e4f01f9a79a58be630947cb959a52d3f2de96f210d49247c33a6226dc2a52ee541069ed3c621f8767fd36a061e9a61adb5d1dd34499d99a1ce6baa496b4f5e2268bfc52c3eea4a6b7b5181f08524aee
> 
> ****** Regenerate the certificate from IMA measurement log ******
> 
> root@nramas:/home/nramas# cat 
> /sys/kernel/security/ima/ascii_runtime_measurements | grep " .ima" | cut 
> -d' ' -f 6 | xxd -r -p > ima-cert.der
> 
> root@nramas:/home/nramas# openssl x509 -in ima-cert.der -inform DER 
> -text -noout

Only the commands to validate the "key" measurement and extract the
certificate need to be included in the patch description.  You could
combine these two commands using "tee".  One would save the
certificate, while the other would calculate the template data hash.
 Providing the openssl command to display the saved certificate is
optional.

Mimi

