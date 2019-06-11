Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2B03C3F0
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jun 2019 08:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403950AbfFKG3M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jun 2019 02:29:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726431AbfFKG3L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jun 2019 02:29:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5B6RMMh099633
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2019 02:29:09 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t25e3kfr0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2019 02:29:09 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 11 Jun 2019 07:29:08 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 07:29:02 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5B6T0l922610362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 06:29:00 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABEE6C605D;
        Tue, 11 Jun 2019 06:29:00 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1485C6055;
        Tue, 11 Jun 2019 06:28:51 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.227.34])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 06:28:51 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v11 00/13] Appended signatures support for IMA appraisal
Date:   Tue, 11 Jun 2019 03:28:04 -0300
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061106-0036-0000-0000-00000AC971EA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011245; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216304; UDB=6.00639510; IPR=6.00997403;
 MB=3.00027259; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 06:29:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061106-0037-0000-0000-00004C2DD766
Message-Id: <20190611062817.18412-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110044
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

Nothing big in this version. Noteworthy changes are:

1. Fixes for two bugs in ima_appraise_measurements() which were spotted and
resolved by Mimi Zohar. The changelog points them out.

2. One bugfix in process_measurement() which would cause all files
appraised with modsig to be measured as well, even if the policy didn't
request it.

3. Adapted to work with per policy rule template formats.

Plus small cosmetic changes in some places. The changelog has the details.

This has been tested with signed modules and with signed kernels loaded via
kexec_file_load().

Many thanks to Mimi Zohar for her help with the development of this patch
series.

The patches apply on today's linux-integrity/next-queued-testing.

Original cover letter:

On the OpenPOWER platform, secure boot and trusted boot are being
implemented using IMA for taking measurements and verifying signatures.
Since the kernel image on Power servers is an ELF binary, kernels are
signed using the scripts/sign-file tool and thus use the same signature
format as signed kernel modules.

This patch series adds support in IMA for verifying those signatures.
It adds flexibility to OpenPOWER secure boot, because it allows it to boot
kernels with the signature appended to them as well as kernels where the
signature is stored in the IMA extended attribute.

Changes since v10:

- Patch "MODSIGN: Export module signature definitions"
  - Moved config MODULE_SIG_FORMAT definition before its use. Suggested by
    Mimi Zohar.
  - Added missing kerneldoc for @name parameter. Suggested by Mimi Zohar.

- Patch "ima: Implement support for module-style appended signatures"
  - Bugfix: don't check status variable when deciding whether to verify
    modsig in ima_appraise_measurement(). Suggested by Mimi Zohar.
  - Bugfix: verify the modsig in ima_appraise_measurement() if the xattr
    contains a digest. Suggested by Mimi Zohar.

- Patch "ima: Define ima-modsig template"
  - Renamed ima_modsig_serialize() to ima_get_raw_modsig().
  - Renamed check_current_template_modsig() to check_template_modsig().
  - Fixed outdated comment in ima_eventmodsig_init(). Suggested by Mimi
    Zohar.
  - Check either the global or the per-rule template when an appraisal rule
    allows modsig. Suggested by Mimi Zohar.

- Patch "ima: Store the measurement again when appraising a modsig"
  - Bugfix: Only re-measure file containing modsig if it was measured
    before.
  - Check for modsig-related fields in the template_desc obtained in
    process_measurement() which can be a per-rule template. Suggested by Mimi
    Zohar.

- Patch "ima: Allow template= option for appraise rules as well"
  - New patch. Suggested by Mimi Zohar.

Changes since v9:

- Patch "MODSIGN: Export module signature definitions"
  - Moved mod_check_sig() to a new file so that CONFIG_IMA_APPRAISE_MODSIG
    doesn't have to depend on CONFIG_MODULES.
  - Changed scripts/Makefile to build sign-file if CONFIG_MODULE_SIG_FORMAT
    is set.
  - Removed Mimi's Reviewed-by because of the changes in this version.

- Patch "PKCS#7: Refactor verify_pkcs7_signature()"
  - Don't add function pkcs7_get_message_sig() anymore, since it's not
    needed in the current version.

- Patch "PKCS#7: Introduce pkcs7_get_digest()"
  - Changed 'len' argument from 'u8 *' to 'u32 *'.
  - Added 'hash_algo' argument to obtain the algo used for the digest.
  - Don't check whether 'buf', 'len' and 'hash_algo' output arguments are NULL,
    since the function's only caller always sets them.
  - Removed Mimi's Reviewed-by because of the changes in this version.

- Patch "integrity: Introduce asymmetric_sig_has_known_key()"
  - Dropped.

- Patch "integrity: Introduce integrity_keyring_from_id"
  - Squashed into "ima: Implement support for module-style appended signatures"
  - Changed integrity_keyring_from_id() to a static function (suggested by Mimi
    Zohar).

- Patch "ima: Introduce is_signed()"
  - Dropped.

- Patch "ima: Export func_tokens"
  - Squashed into "ima: Implement support for module-style appended signatures"

- Patch "ima: Use designated initializers for struct ima_event_data"
  - New patch.

- Patch "ima: Factor xattr_verify() out of ima_appraise_measurement()"
  - New patch.

- Patch "ima: Implement support for module-style appended signatures"
  - Renamed 'struct modsig_hdr' to 'struct modsig'.
  - Added integrity_modsig_verify() to integrity/digsig.c so that it's not
    necessary to export integrity_keyring_from_id() (Suggested by Mimi Zohar).
  - Don't add functions ima_xattr_sig_known_key() and
    modsig_has_known_key() since they're not necessary anymore.
  - Added modsig argument to ima_appraise_measurement().
  - Verify modsig in a separate function called by ima_appraise_measurement().
  - Renamed ima_read_collect_modsig() to ima_read_modsig(), with a separate
    collect function added in patch "ima: Collect modsig" (suggested by Mimi
    Zohar).
  - In ima_read_modsig(), moved code saving of raw PKCS7 data to 'struct
    modsig' to patch "ima: Collect modsig".
  - In ima_read_modsig(), moved all parts related to the modsig hash to
    patch "ima: Collect modsig".
  - In ima_read_modsig(), don't check if the buf pointer is NULL since it's
    never supposed to happen.
  - Renamed ima_free_xattr_data() to ima_free_modsig().
  - No need to check for modsig in ima_read_xattr() and
    ima_inode_set_xattr() anymore.
  - In ima_modsig_verify(), don't check if the modsig pointer is NULL since
    it's not supposed to happen.
  - Don't define IMA_MODSIG element in enum evm_ima_xattr_type.

- Patch "ima: Collect modsig"
  - New patch.

- Patch "ima: Define ima-modsig template"
  - Patch renamed from "ima: Add new "d-sig" template field"
  - Renamed 'd-sig' template field to 'd-modsig'.
  - Added 'modsig' template field.
  - Added 'ima-modsig' defined template descriptor.
  - Renamed ima_modsig_serialize_data() to ima_modsig_serialize().
  - Renamed ima_get_modsig_hash() to ima_get_modsig_digest(). Also the
    function is a lot simpler now since what it used to do is now done in
    ima_collect_modsig() and pkcs7_get_digest().
  - Added check for failed modsig collection in ima_eventdigest_modsig_init().
  - Added modsig argument to ima_store_measurement().
  - Added 'modsig' field to struct ima_event_data.
  - Removed check for modsig == NULL in ima_get_modsig_digest() and in
    ima_modsig_serialize_data() since their callers already performs that
    check.
  - Moved check_current_template_modsig() to this patch, previously was in
    "ima: Store the measurement again when appraising a modsig".

- Patch "ima: Store the measurement again when appraising a modsig"
  - Renamed ima_template_has_sig() to ima_template_has_modsig().
  - Added a change to ima_collect_measurement(), making it to call
    ima_collect_modsig() even if IMA_COLLECT is set in iint->flags.
  - Removed IMA_READ_MEASURE flag.
  - Renamed template_has_sig global variable to template_has_modsig.
  - Renamed find_sig_in_template() to find_modsig_in_template().


Thiago Jung Bauermann (13):
  MODSIGN: Export module signature definitions
  PKCS#7: Refactor verify_pkcs7_signature()
  PKCS#7: Introduce pkcs7_get_digest()
  integrity: Introduce struct evm_xattr
  integrity: Select CONFIG_KEYS instead of depending on it
  ima: Use designated initializers for struct ima_event_data
  ima: Add modsig appraise_type option for module-style appended
    signatures
  ima: Factor xattr_verify() out of ima_appraise_measurement()
  ima: Implement support for module-style appended signatures
  ima: Collect modsig
  ima: Define ima-modsig template
  ima: Store the measurement again when appraising a modsig
  ima: Allow template= option for appraise rules as well

 Documentation/ABI/testing/ima_policy      |   6 +-
 Documentation/security/IMA-templates.rst  |   7 +-
 certs/system_keyring.c                    |  61 +++++--
 crypto/asymmetric_keys/pkcs7_verify.c     |  33 ++++
 include/crypto/pkcs7.h                    |   4 +
 include/linux/module.h                    |   3 -
 include/linux/module_signature.h          |  44 +++++
 include/linux/verification.h              |  10 ++
 init/Kconfig                              |   6 +-
 kernel/Makefile                           |   1 +
 kernel/module.c                           |   1 +
 kernel/module_signature.c                 |  46 +++++
 kernel/module_signing.c                   |  56 +-----
 scripts/Makefile                          |   2 +-
 security/integrity/Kconfig                |   2 +-
 security/integrity/digsig.c               |  43 ++++-
 security/integrity/evm/evm_main.c         |   8 +-
 security/integrity/ima/Kconfig            |  13 ++
 security/integrity/ima/Makefile           |   1 +
 security/integrity/ima/ima.h              |  60 ++++++-
 security/integrity/ima/ima_api.c          |  34 +++-
 security/integrity/ima/ima_appraise.c     | 199 ++++++++++++++--------
 security/integrity/ima/ima_init.c         |   4 +-
 security/integrity/ima/ima_main.c         |  24 ++-
 security/integrity/ima/ima_modsig.c       | 169 ++++++++++++++++++
 security/integrity/ima/ima_policy.c       |  68 +++++++-
 security/integrity/ima/ima_template.c     |  26 ++-
 security/integrity/ima/ima_template_lib.c |  60 ++++++-
 security/integrity/ima/ima_template_lib.h |   4 +
 security/integrity/integrity.h            |  26 +++
 30 files changed, 840 insertions(+), 181 deletions(-)
 create mode 100644 include/linux/module_signature.h
 create mode 100644 kernel/module_signature.c
 create mode 100644 security/integrity/ima/ima_modsig.c

